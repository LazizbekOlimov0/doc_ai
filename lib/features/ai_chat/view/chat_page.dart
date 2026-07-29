import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../gen/strings.g.dart';
import '../../../features/auth/bloc/auth_cubit.dart';
import '../bloc/chat_cubit.dart';
import '../bloc/chat_state.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  late final ChatCubit _cubit;

  @override
  void initState() {
    super.initState();
    final authCubit = context.read<AuthCubit>();
    final userId = authCubit.state.user?.uid;
    if (userId == null) {
      throw StateError('User must be authenticated to access chat');
    }
    _cubit = ChatCubit(patientId: userId);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _cubit.close();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(title: Text(t.aiChat.title), centerTitle: true),
        body: BlocConsumer<ChatCubit, ChatState>(
          listener: (context, state) => _scrollToBottom(),
          builder: (context, state) {
            return Column(
              children: [
                if (state.error != null)
                  MaterialBanner(
                    content: Text(state.error!),
                    backgroundColor: Theme.of(context).colorScheme.errorContainer,
                    actions: [
                      TextButton(
                        onPressed: () => context.read<ChatCubit>().clearError(),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(12),
                    itemCount: state.messages.length + (state.isAiTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == state.messages.length) {
                        return const _TypingBubble();
                      }
                      final msg = state.messages[index];
                      return _ChatBubble(message: msg);
                    },
                  ),
                ),
                _ChatInputBar(
                  controller: _controller,
                  enabled: !state.isAiTyping,
                  onSend: () {
                    final text = _controller.text;
                    context.read<ChatCubit>().sendMessage(text);
                    _controller.clear();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final ChatMessage message;
  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isUser ? colorScheme.primaryContainer : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(message.text, style: TextStyle(color: isUser ? colorScheme.onPrimaryContainer : colorScheme.onSurface)),
      ),
    );
  }
}

class _TypingBubble extends StatelessWidget {
  const _TypingBubble();

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        child: SizedBox(
          width: 40,
          height: 24,
          child: _DotLoader(),
        ),
      ),
    );
  }
}

class _DotLoader extends StatefulWidget {
  const _DotLoader();
  @override
  State<_DotLoader> createState() => _DotLoaderState();
}

class _DotLoaderState extends State<_DotLoader> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(3, (i) {
            final delay = i * 0.2;
            final t = (_ctrl.value - delay).clamp(0.0, 1.0);
            final size = 6.0 + (t < 0.5 ? t * 2 : (1 - t) * 2) * 6;
            return Container(
              width: size,
              height: size,
              decoration: BoxDecoration(color: colorScheme.onSurfaceVariant, shape: BoxShape.circle),
            );
          }),
        );
      },
    );
  }
}

class _ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;
  final VoidCallback onSend;

  const _ChatInputBar({
    required this.controller,
    required this.enabled,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(top: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.3))),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              enabled: enabled,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: t.aiChat.inputHint,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              ),
              onSubmitted: enabled ? (_) => onSend() : null,
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filled(
            onPressed: enabled ? onSend : null,
            icon: const Icon(Icons.send_rounded),
            style: IconButton.styleFrom(backgroundColor: colorScheme.primary),
          ),
        ],
      ),
    );
  }
}
