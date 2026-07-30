import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/models/app_user.dart';

abstract class DoctorConnectState extends Equatable {
  const DoctorConnectState();
  @override
  List<Object?> get props => [];
}

class DoctorConnectInitial extends DoctorConnectState {}

class DoctorConnectLoading extends DoctorConnectState {}

class DoctorConnectLoaded extends DoctorConnectState {
  final List<AppUser> doctors;
  final String? linkedDoctorId;
  final bool isLinking;

  const DoctorConnectLoaded({
    required this.doctors,
    this.linkedDoctorId,
    this.isLinking = false,
  });

  DoctorConnectLoaded copyWith({
    List<AppUser>? doctors,
    String? linkedDoctorId,
    bool? isLinking,
  }) {
    return DoctorConnectLoaded(
      doctors: doctors ?? this.doctors,
      linkedDoctorId: linkedDoctorId ?? this.linkedDoctorId,
      isLinking: isLinking ?? this.isLinking,
    );
  }

  @override
  List<Object?> get props => [doctors, linkedDoctorId, isLinking];
}

class DoctorConnectError extends DoctorConnectState {
  final String message;
  const DoctorConnectError(this.message);
  @override
  List<Object?> get props => [message];
}

class DoctorConnectCubit extends Cubit<DoctorConnectState> {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  DoctorConnectCubit({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance,
        super(DoctorConnectInitial());

  void loadDoctors() async {
    emit(DoctorConnectLoading());
    try {
      final uid = _auth.currentUser?.uid;
      debugPrint('🔵 DoctorConnect: loading doctors, currentUser=$uid');

      final docs = await _firestore
          .collection('users')
          .where('role', isEqualTo: 'doctor')
          .get();

      debugPrint('🔵 DoctorConnect: found ${docs.docs.length} doctors');

      final doctors = docs.docs.map((d) => AppUser.fromFirestore(d)).toList();

      String? linkedDoctorId;
      if (uid != null) {
        final currentUserDoc = await _firestore
            .collection('users')
            .doc(uid)
            .get();
        linkedDoctorId = currentUserDoc.data()?['linkedDoctorId'] as String?;
        debugPrint('🔵 DoctorConnect: linkedDoctorId=$linkedDoctorId');
      }

      emit(DoctorConnectLoaded(
        doctors: doctors,
        linkedDoctorId: linkedDoctorId,
      ));
    } catch (e) {
      debugPrint('🔴 DoctorConnect ERROR: $e');
      emit(const DoctorConnectError('Shifokorlar ro\'yxatini yuklab bo\'lmadi'));
    }
  }

  void linkDoctor(String doctorId) async {
    final current = state;
    if (current is! DoctorConnectLoaded) return;

    emit(current.copyWith(isLinking: true));

    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser?.uid)
          .update({'linkedDoctorId': doctorId});

      emit(current.copyWith(linkedDoctorId: doctorId, isLinking: false));
    } catch (e) {
      emit(current.copyWith(isLinking: false));
      emit(const DoctorConnectError('Shifokorni ulashda xatolik yuz berdi'));
    }
  }
}
