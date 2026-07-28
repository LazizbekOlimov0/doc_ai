import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/chat_repository.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _repository;

  ChatCubit({ChatRepository? repository})
      : _repository = repository ?? FirebaseChatRepository(),
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
      final aiReplyText = await _repository.askDocAiAgent(patientMessage: text);

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
      emit(state.copyWith(
        isAiTyping: false,
        error: 'Javob olishda xatolik yuz berdi. Qayta urinib ko\'ring.',
      ));
    }
  }

  void clearError() => emit(state.copyWith(error: null));
}
