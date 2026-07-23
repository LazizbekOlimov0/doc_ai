import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

class NotificationService {
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;
  NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  static const String _channelId = 'medication_reminders';
  static const String _channelName = 'Dori eslatmalari';
  static const String _followUpChannelId = 'medication_followups';
  static const String _followUpChannelName = 'Qayta eslatmalar';

  static int notificationId(String medicationId, int slotIndex) {
    return '${medicationId}_$slotIndex'.hashCode.abs();
  }

  static int followUpId(int baseId) => -baseId;

  Future<void> init() async {
    if (_initialized) return;

    tz_data.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Tashkent'));

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    _initialized = true;
  }

  void _onNotificationTap(NotificationResponse response) {
    final payload = response.payload;
    if (payload != null) {
      try {
        final data = jsonDecode(payload) as Map<String, dynamic>;
        final navigator = NavigationService.navigatorKey;
        if (navigator.currentContext != null) {
          navigator.currentState?.pushNamed('/patient/medications');
        }
      } catch (_) {}
    }
  }

  Future<bool> requestPermission() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      final granted = await android.requestNotificationsPermission();
      if (granted == true) return true;
      try {
        return await android.requestExactAlarmsPermission() ?? false;
      } catch (_) {
        return false;
      }
    }
    return true;
  }

  Future<void> scheduleMedicationReminder({
    required String medicationName,
    required int hour,
    required int minute,
    required int id,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _plugin.zonedSchedule(
      id,
      medicationName,
      '${medicationName}ni qabul qilish vaqti — ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}',
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: 'Dori qabul qilish vaqtlari haqida eslatmalar',
          importance: Importance.high,
          priority: Priority.high,
          showWhen: true,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: jsonEncode({'medicationName': medicationName, 'hour': hour, 'minute': minute}),
    );
  }

  Future<void> scheduleFollowUpReminder({
    required String medicationName,
    required int id,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    final followUpTime = now.add(const Duration(minutes: 1)); // 30 daqiqa production'da

    await _plugin.zonedSchedule(
      followUpId(id),
      '⏰ ${medicationName}',
      '${medicationName}ni ichishni unutdingizmi?',
      followUpTime,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _followUpChannelId,
          _followUpChannelName,
          channelDescription: 'Dori qabul qilish esdan chiqqanda qayta eslatmalar',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelReminder(int id) async {
    await _plugin.cancel(id);
    await _plugin.cancel(followUpId(id));
  }

  Future<void> cancelAllForMedication(String medicationId) async {
    final pending = await _plugin.pendingNotificationRequests();
    for (final req in pending) {
      try {
        final data = jsonDecode(req.payload ?? '{}') as Map<String, dynamic>;
        if (data['medicationName'] == medicationId) {
          await _plugin.cancel(req.id);
        }
      } catch (_) {}
    }
  }

  Future<void> showTestNotification() async {
    await _plugin.show(
      9999,
      'Test eslatma',
      'Bu test notification — 10 soniyadan keyin chiqdi',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: 'Test',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }
}

/// Simple global navigator key for notification tap navigation
class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
