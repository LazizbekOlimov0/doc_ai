import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/mock_data.dart';
import '../bloc/doctor_dashboard_cubit.dart';
import '../bloc/doctor_dashboard_state.dart';

class DoctorPatientDetailScreen extends StatelessWidget {
  final String patientId;

  const DoctorPatientDetailScreen({super.key, required this.patientId});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<DoctorDashboardCubit, DoctorDashboardState>(
      builder: (context, state) {
        final patient = state.patients
            .where((p) => p.id == patientId)
            .firstOrNull;

        if (patient == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Bemor topilmadi')),
            body: const Center(child: Text('Bemor ma\'lumotlari topilmadi')),
          );
        }

        return Scaffold(
          appBar: AppBar(title: Text(patient.name)),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: colorScheme.primaryContainer,
                          child: Text(
                            patient.name[0],
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          patient.name,
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${patient.age} yosh • ${patient.condition}',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Oxirgi tashrif: ${_formatDate(patient.lastVisit)}',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.call),
                                label: const Text('Qo\'ng\'iroq'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: FilledButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.chat),
                                label: const Text('Xabar'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Dori qabul qilish',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  CircularProgressIndicator(
                                    value: patient.adherenceRate,
                                    strokeWidth: 5,
                                    backgroundColor:
                                        colorScheme.surfaceContainerHighest,
                                    valueColor: AlwaysStoppedAnimation(
                                      patient.adherenceRate >= 0.8
                                          ? AppColors.adherenceGreen
                                          : patient.adherenceRate >= 0.5
                                              ? AppColors.adherenceYellow
                                              : AppColors.adherenceRed,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      '${(patient.adherenceRate * 100).toInt()}%',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Umumiy adherence',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Dorilarni qabul qilish ko\'rsatkichi',
                                    style: textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (mockMedications.isNotEmpty) ...[
                          const Divider(height: 24),
                          ...mockMedications.take(2).map(
                                (med) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    children: [
                                      Icon(Icons.medication,
                                          size: 20,
                                          color: colorScheme.primary),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          '${med.name} ${med.dosage}',
                                          style: textTheme.bodyMedium,
                                        ),
                                      ),
                                      Text(
                                        'Kuniga ${med.timesPerDay}x',
                                        style: textTheme.bodySmall?.copyWith(
                                          color: colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Tahlil tarixi',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                ...mockAnalysisResults.map(
                  (result) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.analytics,
                                  color: colorScheme.primary, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  result.diagnosis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Text(
                                _formatDate(result.analyzedAt),
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Ishonchlilik: ${(result.confidence * 100).toInt()}%',
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }
}
