import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  const ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [text, isUser, timestamp];
}

class ChatState extends Equatable {
  final List<ChatMessage> messages;
  final bool isAiTyping;
  final String? error;

  const ChatState({
    this.messages = const [],
    this.isAiTyping = false,
    this.error,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isAiTyping,
    String? error,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isAiTyping: isAiTyping ?? this.isAiTyping,
      error: error,
    );
  }

  @override
  List<Object?> get props => [messages, isAiTyping, error];
}
