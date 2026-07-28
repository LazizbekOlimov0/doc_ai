import 'package:equatable/equatable.dart';
import 'doctor_notifications_model.dart';

enum DoctorNotifStatus { initial, loading, loaded, error }

class DoctorNotificationsState extends Equatable {
  final DoctorNotifStatus status;
  final List<DoctorNotification> notifications;
  final String? error;

  const DoctorNotificationsState({
    this.status = DoctorNotifStatus.initial,
    this.notifications = const [],
    this.error,
  });

  DoctorNotificationsState copyWith({
    DoctorNotifStatus? status,
    List<DoctorNotification>? notifications,
    String? error,
  }) {
    return DoctorNotificationsState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, notifications, error];
}
