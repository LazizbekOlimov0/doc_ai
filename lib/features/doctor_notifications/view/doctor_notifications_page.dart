import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../gen/strings.g.dart';
import '../bloc/doctor_notifications_model.dart';
import '../bloc/doctor_notifications_cubit.dart';
import '../bloc/doctor_notifications_state.dart';

class DoctorNotificationsPage extends StatefulWidget {
  const DoctorNotificationsPage({super.key});

  @override
  State<DoctorNotificationsPage> createState() => _DoctorNotificationsPageState();
}

class _DoctorNotificationsPageState extends State<DoctorNotificationsPage> {
  late final DoctorNotificationsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = DoctorNotificationsCubit();
    _cubit.load();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.doctorNotifications.title),
          centerTitle: true,
        ),
        body: BlocBuilder<DoctorNotificationsCubit, DoctorNotificationsState>(
          builder: (context, state) {
            if (state.status == DoctorNotifStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == DoctorNotifStatus.error) {
              return Center(child: Text(state.error ?? 'Error', style: TextStyle(color: colorScheme.error)));
            }

            if (state.notifications.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.notifications_none, size: 56, color: colorScheme.onSurfaceVariant),
                    const SizedBox(height: 12),
                    Text(t.doctorNotifications.empty, style: TextStyle(color: colorScheme.onSurfaceVariant)),
                  ],
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.notifications.length,
              separatorBuilder: (_, i) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final n = state.notifications[index];
                return _NotificationCard(notification: n, cubit: _cubit);
              },
            );
          },
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final DoctorNotification notification;
  final DoctorNotificationsCubit cubit;
  const _NotificationCard({required this.notification, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    Color urgencyColor;
    String urgencyLabel;
    switch (notification.urgency) {
      case 'high':
        urgencyColor = Colors.red;
        urgencyLabel = t.doctorNotifications.urgencyHigh;
        break;
      case 'medium':
        urgencyColor = Colors.orange;
        urgencyLabel = t.doctorNotifications.urgencyMedium;
        break;
      default:
        urgencyColor = Colors.green;
        urgencyLabel = t.doctorNotifications.urgencyLow;
    }

    return Card(
      color: notification.isRead ? null : colorScheme.primaryContainer.withValues(alpha: 0.2),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: urgencyColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(urgencyLabel, style: TextStyle(color: urgencyColor, fontSize: 11, fontWeight: FontWeight.w700)),
                ),
                const Spacer(),
                Text(_formatTime(notification.timestamp), style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant)),
              ],
            ),
            const SizedBox(height: 8),
            Text(notification.patientName, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(notification.possibleCondition.isEmpty ? t.doctorNotifications.newAiDiagnosis : notification.possibleCondition,
                style: TextStyle(color: colorScheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final d = '${dt.day.toString().padLeft(2, '0')}.${dt.month.toString().padLeft(2, '0')}';
    final t = '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    return '$d $t';
  }
}
