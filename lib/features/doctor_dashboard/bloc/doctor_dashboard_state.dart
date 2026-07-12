import 'package:equatable/equatable.dart';
import '../../../models/mock_data.dart';

class DoctorDashboardState extends Equatable {
  final List<MockPatient> patients;
  final String searchQuery;
  final MockPatient? selectedPatient;
  final bool isLoading;

  const DoctorDashboardState({
    this.patients = const [],
    this.searchQuery = '',
    this.selectedPatient,
    this.isLoading = false,
  });

  List<MockPatient> get filteredPatients {
    if (searchQuery.isEmpty) return patients;
    return patients
        .where((p) => p.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  DoctorDashboardState copyWith({
    List<MockPatient>? patients,
    String? searchQuery,
    MockPatient? selectedPatient,
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
