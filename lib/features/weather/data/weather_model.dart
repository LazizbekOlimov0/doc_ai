class WeatherHelper {
  static String conditionText(int code, Map<String, String> conditions) {
    final key = _codeToKey(code);
    return conditions[key] ?? conditions['unknown'] ?? '';
  }

  static String _codeToKey(int code) {
    if (code == 0) return 'clear';
    if (code <= 3) return 'partly_cloudy';
    if (code <= 48) return 'fog';
    if (code <= 67) return 'rain';
    if (code <= 77) return 'snow';
    if (code <= 99) return 'thunderstorm';
    return 'unknown';
  }

  static String conditionEmoji(int code) {
    if (code == 0) return '☀️';
    if (code <= 3) return '⛅';
    if (code <= 48) return '🌫️';
    if (code <= 57) return '🌦️';
    if (code <= 67) return '🌧️';
    if (code <= 77) return '❄️';
    if (code <= 82) return '🌧️';
    if (code <= 86) return '🌨️';
    if (code <= 99) return '⛈️';
    return '❓';
  }
}

class DailyForecast {
  final DateTime date;
  final double maxTemp;
  final double minTemp;
  final int weatherCode;

  const DailyForecast({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.weatherCode,
  });

  String conditionText(Map<String, String> conditions) =>
      WeatherHelper.conditionText(weatherCode, conditions);

  String get conditionEmoji => WeatherHelper.conditionEmoji(weatherCode);

  String dayLabel(Map<String, String> labels) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final forecastDay = DateTime(date.year, date.month, date.day);
    final diff = forecastDay.difference(today).inDays;

    if (diff == 0) return labels['today'] ?? 'Bugun';
    if (diff == 1) return labels['tomorrow'] ?? 'Ertaga';

    const weekdays = [
      'monday', 'tuesday', 'wednesday', 'thursday',
      'friday', 'saturday', 'sunday',
    ];
    final weekday = date.weekday - 1;
    if (weekday >= 0 && weekday < 7) {
      return labels[weekdays[weekday]] ?? _fallbackWeekday(date.weekday);
    }
    return _fallbackWeekday(date.weekday);
  }

  static String _fallbackWeekday(int weekday) {
    const names = [
      'Dushanba', 'Seshanba', 'Chorshanba',
      'Payshanba', 'Juma', 'Shanba', 'Yakshanba',
    ];
    return names[weekday - 1];
  }
}

class WeatherModel {
  final double temperature;
  final int humidity;
  final int weatherCode;
  final double windSpeed;
  final String locationName;
  final List<DailyForecast> weeklyForecast;

  const WeatherModel({
    required this.temperature,
    required this.humidity,
    required this.weatherCode,
    required this.windSpeed,
    required this.locationName,
    this.weeklyForecast = const [],
  });

  String conditionText(Map<String, String> conditions) =>
      WeatherHelper.conditionText(weatherCode, conditions);

  String get conditionEmoji => WeatherHelper.conditionEmoji(weatherCode);

  factory WeatherModel.fromJson(Map<String, dynamic> json, String locationName) {
    final current = json['current'] as Map<String, dynamic>;
    final daily = json['daily'] as Map<String, dynamic>?;

    final forecast = <DailyForecast>[];
    if (daily != null) {
      final times = (daily['time'] as List<dynamic>).cast<String>();
      final codes = (daily['weather_code'] as List<dynamic>).cast<num>();
      final maxTemps = (daily['temperature_2m_max'] as List<dynamic>).cast<num>();
      final minTemps = (daily['temperature_2m_min'] as List<dynamic>).cast<num>();

      for (var i = 0; i < times.length; i++) {
        forecast.add(DailyForecast(
          date: DateTime.parse(times[i]),
          maxTemp: maxTemps[i].toDouble(),
          minTemp: minTemps[i].toDouble(),
          weatherCode: codes[i].toInt(),
        ));
      }
    }

    return WeatherModel(
      temperature: (current['temperature_2m'] as num).toDouble(),
      humidity: (current['relative_humidity_2m'] as num).toInt(),
      weatherCode: (current['weather_code'] as num).toInt(),
      windSpeed: (current['wind_speed_10m'] as num).toDouble(),
      locationName: locationName,
      weeklyForecast: forecast,
    );
  }
}
