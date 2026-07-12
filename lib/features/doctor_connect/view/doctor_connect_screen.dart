import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/mock_data.dart';

class DoctorConnectScreen extends StatelessWidget {
  const DoctorConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Shifokor bilan bog\'lanish')),
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
                      child: Icon(
                        Icons.person,
                        size: 48,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      mockDoctor.name,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        mockDoctor.specialty,
                        style: TextStyle(
                          color: colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.local_hospital,
                            size: 16, color: colorScheme.onSurfaceVariant),
                        const SizedBox(width: 4),
                        Text(
                          mockDoctor.hospital,
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, size: 16, color: Colors.amber[700]),
                        const SizedBox(width: 4),
                        Text(
                          '${mockDoctor.rating} • ${mockDoctor.experienceYears} yillik tajriba',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.call),
                            label: const Text('Qo\'ng\'iroq'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.chat),
                            label: const Text('Xabar yozish'),
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
              'Hisobot yuborish',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.description_outlined,
                            color: colorScheme.primary),
                        const SizedBox(width: 8),
                        Text(
                          'Haftalik hisobot',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _StatusChip(
                          label: 'Oxirgi: 07.07.2026',
                          color: AppColors.adherenceGreen,
                        ),
                        const SizedBox(width: 8),
                        _StatusChip(
                          label: 'Holat: Yaxshi',
                          color: AppColors.adherenceYellow,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.send),
                        label: const Text('Hisobot yuborish'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.assignment_outlined,
                            color: colorScheme.primary),
                        const SizedBox(width: 8),
                        Text(
                          'Sog\'liq kundaligi',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _StatusChip(
                          label: '07.07 — Bosim: 120/80',
                          color: colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        _StatusChip(
                          label: '06.07 — Puls: 72',
                          color: colorScheme.primary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                        label: const Text('Yangi yozuv qo\'shish'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w500),
      ),
    );
  }
}
