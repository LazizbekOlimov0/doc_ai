import 'package:equatable/equatable.dart';

class BookingState extends Equatable {
  final String? selectedDoctor;
  final DateTime? selectedDate;
  final String? selectedTime;
  final String reason;
  final bool isSubmitting;
  final bool isSuccess;

  const BookingState({
    this.selectedDoctor,
    this.selectedDate,
    this.selectedTime,
    this.reason = '',
    this.isSubmitting = false,
    this.isSuccess = false,
  });

  BookingState copyWith({
    String? selectedDoctor,
    DateTime? selectedDate,
    String? selectedTime,
    String? reason,
    bool? isSubmitting,
    bool? isSuccess,
  }) {
    return BookingState(
      selectedDoctor: selectedDoctor ?? this.selectedDoctor,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      reason: reason ?? this.reason,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [
        selectedDoctor,
        selectedDate,
        selectedTime,
        reason,
        isSubmitting,
        isSuccess,
      ];
}
