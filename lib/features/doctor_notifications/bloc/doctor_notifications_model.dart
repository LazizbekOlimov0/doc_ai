import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorNotification {
  final String id;
  final String patientId;
  final String patientName;
  final String diagnosisId;
  final String possibleCondition;
  final String urgency;
  final String chatId;
  final DateTime timestamp;
  final bool isRead;

  const DoctorNotification({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.diagnosisId,
    required this.possibleCondition,
    required this.urgency,
    required this.chatId,
    required this.timestamp,
    this.isRead = false,
  });

  factory DoctorNotification.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DoctorNotification(
      id: doc.id,
      patientId: data['patientId'] as String,
      patientName: data['patientName'] as String? ?? '',
      diagnosisId: data['diagnosisId'] as String,
      possibleCondition: data['possibleCondition'] as String? ?? '',
      urgency: data['urgency'] as String? ?? 'low',
      chatId: data['chatId'] as String? ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      isRead: data['isRead'] as bool? ?? false,
    );
  }
}
