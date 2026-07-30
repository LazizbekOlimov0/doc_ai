import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/app_user.dart';

class DoctorDashboardState extends Equatable {
  final List<AppUser> patients;
  final String searchQuery;
  final AppUser? selectedPatient;
  final bool isLoading;

  const DoctorDashboardState({
    this.patients = const [],
    this.searchQuery = '',
    this.selectedPatient,
    this.isLoading = false,
  });

  List<AppUser> get filteredPatients {
    if (searchQuery.isEmpty) return patients;
    return patients
        .where((p) => p.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  DoctorDashboardState copyWith({
    List<AppUser>? patients,
    String? searchQuery,
    AppUser? selectedPatient,
    bool? isLoading,
  }) {
    return DoctorDashboardState(
      patients: patients ?? this.patients,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedPatient: selectedPatient ?? this.selectedPatient,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [patients, searchQuery, selectedPatient, isLoading];
}

class DoctorDashboardCubit extends Cubit<DoctorDashboardState> {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  DoctorDashboardCubit({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance,
        super(const DoctorDashboardState());

  void loadPatients() async {
    emit(state.copyWith(isLoading: true));
    try {
      final doctorId = _auth.currentUser?.uid;
      if (doctorId == null) {
        emit(state.copyWith(isLoading: false));
        return;
      }

      debugPrint('🔵 DoctorDashboard: loading patients for doctor=$doctorId');

      final docs = await _firestore
          .collection('users')
          .where('linkedDoctorId', isEqualTo: doctorId)
          .get();

      debugPrint('🔵 DoctorDashboard: found ${docs.docs.length} linked patients');

      final patients = docs.docs.map((d) {
        final data = d.data() as Map<String, dynamic>;
        debugPrint('🔵 DoctorDashboard patient: name=${data['name']}, email=${data['email']}, uid=${d.id}');
        return AppUser.fromFirestore(d);
      }).toList();

      emit(DoctorDashboardState(patients: patients, isLoading: false));
    } catch (e) {
      debugPrint('🔴 DoctorDashboard ERROR: $e');
      emit(state.copyWith(isLoading: false));
    }
  }

  void search(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void selectPatient(AppUser patient) {
    emit(state.copyWith(selectedPatient: patient));
  }
}
