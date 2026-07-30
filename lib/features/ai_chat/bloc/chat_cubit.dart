import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/chat_repository.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _repository;
  final String _patientId;
  final FirebaseFirestore _firestore;

  ChatCubit({
    ChatRepository? repository,
    required String patientId,
    FirebaseFirestore? firestore,
  })  : _repository = repository ?? FirebaseChatRepository(),
        _patientId = patientId,
        _firestore = firestore ?? FirebaseFirestore.instance,
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

      final promptMessage = ChatMessage(
        text: 'Shifokoringizga ushbu tashxis haqida hisobot yuborishni xohlaysizmi?',
        isUser: false,
        timestamp: DateTime.now(),
        showReportPrompt: true,
      );

      emit(state.copyWith(
        messages: [...state.messages, aiMessage, promptMessage],
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

  Future<void> respondToReportPrompt(int promptIndex, bool sendReport) async {
    final messages = List<ChatMessage>.from(state.messages);

    if (sendReport) {
      try {
        final userDoc = await _firestore.collection('users').doc(_patientId).get();
        final userData = userDoc.data() ?? {};
        final linkedDoctorId = userData['linkedDoctorId'] as String?;
        final patientName = userData['name'] as String? ?? 'Bemor';
        final patientEmail = userData['email'] as String? ?? '';
        final patientAge = userData['age'] as int?;
        final patientBloodType = userData['bloodType'] as String?;
        final patientAllergies = List<String>.from(userData['allergies'] as List? ?? []);

        if (linkedDoctorId == null) {
          messages[promptIndex] = ChatMessage(
            text: 'Hisobot yuborish uchun avval shifokor ulashingiz kerak. Shifokorlar bo\'limiga o\'ting.',
            isUser: false,
            timestamp: DateTime.now(),
          );
          emit(state.copyWith(messages: messages));
          return;
        }

        final summaryText = messages
            .where((m) => !m.isUser && !m.showReportPrompt)
            .lastOrNull
            ?.text ?? '';

        final reportData = {
          'patientId': _patientId,
          'patientName': patientName,
          'patientEmail': patientEmail,
          'doctorId': linkedDoctorId,
          'summaryText': summaryText,
          'timestamp': FieldValue.serverTimestamp(),
          if (patientAge != null) 'patientAge': patientAge,
          if (patientBloodType != null) 'patientBloodType': patientBloodType,
          if (patientAllergies.isNotEmpty) 'patientAllergies': patientAllergies,
        };

        await _firestore
            .collection('users')
            .doc(linkedDoctorId)
            .collection('patientReports')
            .add(reportData);

        messages[promptIndex] = ChatMessage(
          text: 'Hisobot shifokoringizga yuborildi ✅',
          isUser: false,
          timestamp: DateTime.now(),
          reportSent: true,
        );
      } catch (e) {
        debugPrint('🔴 Report send ERROR: $e');
        messages[promptIndex] = ChatMessage(
          text: 'Hisobot yuborishda xatolik yuz berdi. Qayta urinib ko\'ring.',
          isUser: false,
          timestamp: DateTime.now(),
        );
      }
    } else {
      messages[promptIndex] = ChatMessage(
        text: 'Hisobot yuborilmadi',
        isUser: false,
        timestamp: DateTime.now(),
        reportSent: true,
      );
    }

    emit(state.copyWith(messages: messages));
  }

  void clearError() => emit(state.copyWith(error: null));
}
