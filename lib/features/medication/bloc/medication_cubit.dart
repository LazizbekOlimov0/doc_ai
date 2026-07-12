import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/mock_data.dart';
import 'medication_state.dart';

class MedicationCubit extends Cubit<MedicationState> {
  MedicationCubit() : super(const MedicationState());

  void loadMedications() {
    emit(state.copyWith(isLoading: true));
    Future.delayed(const Duration(milliseconds: 500), () {
      emit(MedicationState(
        medications: List.from(mockMedications),
        isLoading: false,
      ));
    });
  }

  void toggleTaken(int medicationIndex, int doseIndex) {
    final meds = List<MockMedication>.from(state.medications);
    final med = meds[medicationIndex];
    final taken = List<bool>.from(med.takenToday);
    taken[doseIndex] = !taken[doseIndex];
    meds[medicationIndex] = med.copyWith(takenToday: taken);
    emit(state.copyWith(medications: meds));
  }
}
