import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/chat_repository.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _repository;
  final String _patientId;

  ChatCubit({
    ChatRepository? repository,
    required String patientId,
  })  : _repository = repository ?? FirebaseChatRepository(),
        _patientId = patientId,
        super(const ChatState());

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    if (state.isAiTyping) return;

    final userMessage = ChatMessage(
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    );

    emit(state.copyWith(
      messages: [...state.messages, userMessage],
      isAiTyping: true,
      error: null,
    ));

    try {
      final aiReplyText = await _repository.askDocAiAgent(
        patientMessage: text,
        patientId: _patientId,
      );

      final aiMessage = ChatMessage(
        text: aiReplyText,
        isUser: false,
        timestamp: DateTime.now(),
      );

      emit(state.copyWith(
        messages: [...state.messages, aiMessage],
        isAiTyping: false,
      ));
    } catch (e) {
      debugPrint('🔴 ChatCubit ERROR: $e');
      emit(state.copyWith(
        isAiTyping: false,
        error: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }

  void clearError() => emit(state.copyWith(error: null));
}
