import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../gen/strings.g.dart';
import '../bloc/weather_cubit.dart';

class WeatherDetailScreen extends StatelessWidget {
  const WeatherDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final conditions = {
      'clear': t.weather.clear,
      'partly_cloudy': t.weather.partly_cloudy,
      'fog': t.weather.fog,
      'rain': t.weather.rain,
      'snow': t.weather.snow,
      'thunderstorm': t.weather.thunderstorm,
      'unknown': t.weather.unknown,
    };

    final dayLabels = {
      'today': t.weather.today,
      'tomorrow': t.weather.tomorrow,
      'monday': t.weather.monday,
      'tuesday': t.weather.tuesday,
      'wednesday': t.weather.wednesday,
      'thursday': t.weather.thursday,
      'friday': t.weather.friday,
      'saturday': t.weather.saturday,
      'sunday': t.weather.sunday,
    };

    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state.status == WeatherStatus.loading ||
            state.status == WeatherStatus.initial) {
          return Scaffold(
            appBar: AppBar(title: Text(t.weather.title)),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state.status == WeatherStatus.error || state.weather == null) {
          return Scaffold(
            appBar: AppBar(title: Text(t.weather.title)),
            body: const Center(child: Text('Ob-havo ma\'lumoti mavjud emas')),
          );
        }

        final weather = state.weather!;

        return Scaffold(
          appBar: AppBar(
            title: Text(t.weather.title),
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text(
                      weather.conditionEmoji,
                      style: const TextStyle(fontSize: 64),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${weather.temperature.toStringAsFixed(0)}°C',
                      style: textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      weather.conditionText(conditions),
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      weather.locationName,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _InfoChip(
                          icon: Icons.water_drop,
                          label: '${weather.humidity}%',
                        ),
                        const SizedBox(width: 16),
                        _InfoChip(
                          icon: Icons.air,
                          label: '${weather.windSpeed.toStringAsFixed(1)} km/h',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  t.weather.forecast_7days,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ...weather.weeklyForecast.asMap().entries.map((entry) {
                final index = entry.key;
                final day = entry.value;
                final isToday = index == 0;

                return Container(
                  color: isToday
                      ? colorScheme.primaryContainer.withAlpha(100)
                      : null,
                  child: ListTile(
                    leading: SizedBox(
                      width: 80,
                      child: Text(
                        day.dayLabel(dayLabels),
                        style: TextStyle(
                          fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                          color: isToday
                              ? colorScheme.primary
                              : colorScheme.onSurface,
                        ),
                      ),
                    ),
                    title: Text(
                      day.conditionText(conditions),
                      style: textTheme.bodyMedium,
                    ),
                    trailing: SizedBox(
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${day.maxTemp.toStringAsFixed(0)}°',
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${day.minTemp.toStringAsFixed(0)}°',
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(color: colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}
