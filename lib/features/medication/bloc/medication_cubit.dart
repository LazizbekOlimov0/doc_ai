import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/notification_service.dart';
import '../../../models/mock_data.dart';
import 'medication_state.dart';

class MedicationCubit extends Cubit<MedicationState> {
  final NotificationService _notificationService;

  MedicationCubit({NotificationService? notificationService})
      : _notificationService = notificationService ?? NotificationService(),
        super(const MedicationState());

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

    if (taken[doseIndex] == true) {
      final notifId = NotificationService.notificationId(
        med.name.hashCode.toString(),
        doseIndex,
      );
      _notificationService.cancelReminder(notifId);
    }
  }

  Future<void> scheduleNotificationsForAll() async {
    for (var i = 0; i < state.medications.length; i++) {
      final med = state.medications[i];
      final medId = med.name.hashCode.toString();
      for (var j = 0; j < med.times.length; j++) {
        final timeParts = med.times[j].split(':');
        final hour = int.parse(timeParts[0]);
        final minute = int.parse(timeParts[1]);
        final id = NotificationService.notificationId(medId, j);

        await _notificationService.scheduleMedicationReminder(
          medicationName: med.name,
          hour: hour,
          minute: minute,
          id: id,
        );
      }
    }
  }

  Future<void> scheduleFollowUp({
    required String medicationName,
    required int doseIndex,
  }) async {
    final medId = medicationName.hashCode.toString();
    final id = NotificationService.notificationId(medId, doseIndex);
    await _notificationService.scheduleFollowUpReminder(
      medicationName: medicationName,
      id: id,
    );
  }

  Future<void> testNotification() async {
    await _notificationService.showTestNotification();
  }
}
