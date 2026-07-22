import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/services/location_service.dart';
import 'weather_model.dart';

class WeatherRepository {
  final LocationService _locationService;
  final http.Client _client;

  WeatherRepository({
    LocationService? locationService,
    http.Client? client,
  })  : _locationService = locationService ?? LocationService(),
        _client = client ?? http.Client();

  Future<WeatherModel?> fetchCurrentWeather() async {
    try {
      final location = await _locationService.getCurrentLocation();

      final uri = Uri.parse(
        'https://api.open-meteo.com/v1/forecast'
        '?latitude=${location.lat}'
        '&longitude=${location.lon}'
        '&current=temperature_2m,relative_humidity_2m,weather_code,wind_speed_10m'
        '&daily=weather_code,temperature_2m_max,temperature_2m_min'
        '&timezone=auto'
        '&forecast_days=7',
      );

      final response = await _client.get(uri).timeout(
        const Duration(seconds: 10),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return WeatherModel.fromJson(json, location.name);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  void dispose() {
    _client.close();
  }
}
