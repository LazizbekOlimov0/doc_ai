import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/symptom_cubit.dart';
import '../bloc/symptom_state.dart';

class AnalysisResultScreen extends StatelessWidget {
  const AnalysisResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<SymptomCubit, SymptomState>(
      builder: (context, state) {
        if (state.lastResult == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Tahlil natijasi')),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.analytics_outlined,
                    size: 80,
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Hali tahlil o\'tkazilmagan',
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Bosh sahifadan semptomlaringizni kiriting',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final result = state.lastResult!;
        return Scaffold(
          appBar: AppBar(title: const Text('Tahlil natijasi')),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: colorScheme.primaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.medical_services,
                                color: colorScheme.primary, size: 32),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                result.diagnosis,
                                style: textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(
                          value: result.confidence,
                          backgroundColor:
                              colorScheme.primary.withValues(alpha: 0.2),
                          color: colorScheme.primary,
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Ishonchlilik: ${(result.confidence * 100).toInt()}%',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tavsiyalar',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: result.recommendations
                          .map(
                            (r) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 6),
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: colorScheme.primary,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(child: Text(r)),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Tavsiya etilgan shifoxonalar',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                ...result.hospitals.map(
                  (hospital) => Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: colorScheme.secondaryContainer,
                        child: Icon(Icons.local_hospital,
                            color: colorScheme.onSecondaryContainer),
                      ),
                      title: Text(hospital.name,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text(hospital.address),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${hospital.distanceKm} km',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: colorScheme.primary,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star,
                                  size: 14, color: Colors.amber[700]),
                              Text(' ${hospital.rating}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Eng yaqin apteka',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: colorScheme.tertiaryContainer,
                      child: Icon(Icons.local_pharmacy,
                          color: colorScheme.onTertiaryContainer),
                    ),
                    title: Text(result.pharmacyName,
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: const Text('Dorixona'),
                    trailing: Text(
                      '${result.pharmacyDistance} km',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
