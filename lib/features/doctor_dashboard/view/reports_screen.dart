import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/mock_data.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final mockReports = [
      {
        'patient': mockPatients[0].name,
        'title': 'Haftalik adherence hisoboti',
        'date': '07.07.2026',
        'status': 'Ko\'rib chiqilgan',
        'adherence': 0.85,
        'icon': Icons.check_circle,
        'iconColor': AppColors.adherenceGreen,
      },
      {
        'patient': mockPatients[1].name,
        'title': 'Sog\'liq kundaligi',
        'date': '06.07.2026',
        'status': 'Yangi',
        'adherence': 0.62,
        'icon': Icons.fiber_new,
        'iconColor': Colors.orange,
      },
      {
        'patient': mockPatients[2].name,
        'title': 'Oylik dori hisoboti',
        'date': '05.07.2026',
        'status': 'Ko\'rib chiqilgan',
        'adherence': 0.94,
        'icon': Icons.check_circle,
        'iconColor': AppColors.adherenceGreen,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Hisobotlar')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockReports.length,
        itemBuilder: (context, index) {
          final report = mockReports[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    (report['iconColor'] as Color).withValues(alpha: 0.15),
                child: Icon(
                  report['icon'] as IconData,
                  color: report['iconColor'] as Color,
                  size: 24,
                ),
              ),
              title: Text(
                report['title'] as String,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                '${report['patient']} • ${report['date']}',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: (report['status'] == 'Yangi')
                          ? Colors.orange.withValues(alpha: 0.15)
                          : AppColors.adherenceGreen.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      report['status'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: report['status'] == 'Yangi'
                            ? Colors.orange[700]
                            : AppColors.adherenceGreen,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Adherence: ${((report['adherence'] as double) * 100).toInt()}%',
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
