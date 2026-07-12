import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/mock_data.dart';
import 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(const BookingState());

  List<MockDoctor> get availableDoctors => const [mockDoctor, mockDoctor2];

  void selectDoctor(String name) {
    emit(state.copyWith(selectedDoctor: name));
  }

  void selectDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  void selectTime(String time) {
    emit(state.copyWith(selectedTime: time));
  }

  void updateReason(String reason) {
    emit(state.copyWith(reason: reason));
  }

  void submit() {
    emit(state.copyWith(isSubmitting: true));
    Future.delayed(const Duration(seconds: 1), () {
      emit(BookingState(isSuccess: true));
    });
  }

  void reset() {
    emit(const BookingState());
  }
}
