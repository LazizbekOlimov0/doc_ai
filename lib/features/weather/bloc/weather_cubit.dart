import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/weather_repository.dart';
import '../data/weather_model.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _repository;

  WeatherCubit({WeatherRepository? repository})
      : _repository = repository ?? WeatherRepository(),
        super(const WeatherState());

  Future<void> fetchWeather() async {
    emit(state.copyWith(status: WeatherStatus.loading));
    try {
      final weather = await _repository.fetchCurrentWeather();
      if (weather != null) {
        emit(state.copyWith(status: WeatherStatus.loaded, weather: weather));
      } else {
        emit(state.copyWith(
          status: WeatherStatus.error,
          errorMessage: 'Ob-havo ma\'lumoti topilmadi',
        ));
      }
    } catch (_) {
      emit(state.copyWith(
        status: WeatherStatus.error,
        errorMessage: 'Ob-havo ma\'lumoti olishda xatolik',
      ));
    }
  }

  @override
  Future<void> close() {
    _repository.dispose();
    return super.close();
  }
}
