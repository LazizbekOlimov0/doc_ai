import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../gen/strings.g.dart';
import '../bloc/medication_cubit.dart';
import '../bloc/medication_state.dart';

class MedicationsScreen extends StatefulWidget {
  const MedicationsScreen({super.key});

  @override
  State<MedicationsScreen> createState() => _MedicationsScreenState();
}

class _MedicationsScreenState extends State<MedicationsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MedicationCubit>().loadMedications();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<MedicationCubit, MedicationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.t.medication.title),
            actions: [
              if (kDebugMode)
                IconButton(
                  icon: const Icon(Icons.notifications_active),
                  tooltip: 'Test notification (10s)',
                  onPressed: () {
                    context.read<MedicationCubit>().testNotification();
                  },
                ),
            ],
          ),
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () async {
                    context.read<MedicationCubit>().loadMedications();
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _AdherenceCard(
                          rate: state.overallAdherence,
                          colorScheme: colorScheme,
                          textTheme: textTheme,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          context.t.medication.schedule,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...List.generate(state.medications.length, (i) {
                          final med = state.medications[i];
                          return _MedicationCard(
                            medication: med,
                            index: i,
                            colorScheme: colorScheme,
                            textTheme: textTheme,
                            onToggle: (doseIdx) {
                              context
                                  .read<MedicationCubit>()
                                  .toggleTaken(i, doseIdx);
                            },
                          );
                        }),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class _AdherenceCard extends StatelessWidget {
  final double rate;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _AdherenceCard({
    required this.rate,
    required this.colorScheme,
    required this.textTheme,
  });

  Color get _adherenceColor {
    if (rate >= 0.8) return AppColors.adherenceGreen;
    if (rate >= 0.5) return AppColors.adherenceYellow;
    return AppColors.adherenceRed;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: rate,
                    strokeWidth: 6,
                    backgroundColor: colorScheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation(_adherenceColor),
                  ),
                  Center(
                    child: Text(
                      '${(rate * 100).toInt()}%',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: _adherenceColor,
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
                    context.t.medication.weekly_adherence,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    context.t.medication.adherence_hint,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MedicationCard extends StatelessWidget {
  final dynamic medication;
  final int index;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final void Function(int doseIdx) onToggle;

  const _MedicationCard({
    required this.medication,
    required this.index,
    required this.colorScheme,
    required this.textTheme,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final takenCount =
        medication.takenToday.where((t) => t == true).length;
    final totalCount = medication.takenToday.length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.medication, color: colorScheme.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medication.name,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${medication.dosage} • ${context.t.medication.times_per_day}${medication.timesPerDay}${context.t.medication.times_suffix}',
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$takenCount/$totalCount',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onPrimaryContainer,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
                      '${context.t.medication.today}: ${medication.times.join(', ')}',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: List.generate(medication.times.length, (i) {
                final isTaken = medication.takenToday[i];
                return FilterChip(
                  label: Text(medication.times[i]),
                  selected: isTaken,
                  onSelected: (_) => onToggle(i),
                  avatar: Icon(
                    isTaken ? Icons.check_circle : Icons.radio_button_unchecked,
                    size: 18,
                    color: isTaken
                        ? AppColors.adherenceGreen
                        : colorScheme.onSurfaceVariant,
                  ),
                  selectedColor: AppColors.adherenceGreen.withValues(alpha: 0.15),
                  checkmarkColor: Colors.transparent,
                  side: BorderSide.none,
                );
              }),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: takenCount > 0 ? takenCount / totalCount : 0,
              backgroundColor: colorScheme.surfaceContainerHighest,
              color: AppColors.adherenceGreen,
              minHeight: 3,
              borderRadius: BorderRadius.circular(2),
            ),
          ],
        ),
      ),
    );
  }
}
