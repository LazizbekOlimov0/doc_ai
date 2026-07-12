import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/mock_data.dart';
import 'doctor_dashboard_state.dart';

class DoctorDashboardCubit extends Cubit<DoctorDashboardState> {
  DoctorDashboardCubit() : super(const DoctorDashboardState());

  void loadPatients() {
    emit(state.copyWith(isLoading: true));
    Future.delayed(const Duration(milliseconds: 500), () {
      emit(DoctorDashboardState(
        patients: List.from(mockPatients),
        isLoading: false,
      ));
    });
  }

  void search(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void selectPatient(String id) {
    final patient = state.patients.where((p) => p.id == id).firstOrNull;
    emit(state.copyWith(selectedPatient: patient));
  }
}
