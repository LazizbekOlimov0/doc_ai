import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PatientReport {
  final String id;
  final String patientId;
  final String patientName;
  final String patientEmail;
  final int? patientAge;
  final String? patientBloodType;
  final List<String> patientAllergies;
  final String summaryText;
  final DateTime timestamp;

  const PatientReport({
    required this.id,
    required this.patientId,
    required this.patientName,
    this.patientEmail = '',
    this.patientAge,
    this.patientBloodType,
    this.patientAllergies = const [],
    required this.summaryText,
    required this.timestamp,
  });

  factory PatientReport.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PatientReport(
      id: doc.id,
      patientId: data['patientId'] as String? ?? '',
      patientName: data['patientName'] as String? ?? '',
      patientEmail: data['patientEmail'] as String? ?? '',
      patientAge: data['patientAge'] as int?,
      patientBloodType: data['patientBloodType'] as String?,
      patientAllergies: List<String>.from(data['patientAllergies'] as List? ?? []),
      summaryText: data['summaryText'] as String? ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}

abstract class DoctorReportsState extends Equatable {
  const DoctorReportsState();
  @override
  List<Object?> get props => [];
}

class DoctorReportsLoading extends DoctorReportsState {}

class DoctorReportsLoaded extends DoctorReportsState {
  final Map<String, List<PatientReport>> reportsByPatient;

  const DoctorReportsLoaded(this.reportsByPatient);

  @override
  List<Object?> get props => [reportsByPatient];
}

class DoctorReportsError extends DoctorReportsState {
  final String message;
  const DoctorReportsError(this.message);
  @override
  List<Object?> get props => [message];
}

class DoctorReportsCubit extends Cubit<DoctorReportsState> {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  StreamSubscription? _subscription;

  DoctorReportsCubit({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance,
        super(DoctorReportsLoading());

  Stream<Map<String, List<PatientReport>>> watchReports() {
    final doctorId = _auth.currentUser?.uid;
    if (doctorId == null) return Stream.value({});

    return _firestore
        .collection('users')
        .doc(doctorId)
        .collection('patientReports')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      final reports = snapshot.docs
          .map((doc) => PatientReport.fromFirestore(doc))
          .toList();

      final grouped = <String, List<PatientReport>>{};
      for (final r in reports) {
        grouped.putIfAbsent(r.patientId, () => []).add(r);
      }
      return grouped;
    });
  }

  void loadReports() {
    _subscription?.cancel();
    _subscription = watchReports().listen((grouped) {
      if (!isClosed) emit(DoctorReportsLoaded(grouped));
    }, onError: (e) {
      if (!isClosed) emit(const DoctorReportsError('Hisobotlarni yuklab bo\'lmadi'));
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
