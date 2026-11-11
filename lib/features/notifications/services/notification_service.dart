import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../../core/constants/app_constants.dart';
import '../../reminders/domain/entities/reminder.dart';

class NotificationService {
  NotificationService._();

  static final _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    final timezoneInfo = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezoneInfo.identifier));

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);

    await _plugin.initialize(initSettings);
    await _createChannels();
  }

  static Future<void> _createChannels() async {
    final androidPlugin =
        _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        AppConstants.channelDueToday,
        AppConstants.channelDueTodayName,
        description: 'Notifications for reminders due today',
        importance: Importance.high,
      ),
    );
    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        AppConstants.channelUpcoming,
        AppConstants.channelUpcomingName,
        description: 'Upcoming reminder alerts',
        importance: Importance.defaultImportance,
      ),
    );
    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        AppConstants.channelOverdue,
        AppConstants.channelOverdueName,
        description: 'Overdue reminder alerts',
        importance: Importance.high,
      ),
    );
  }

  static Future<void> scheduleForReminder(
    Reminder reminder,
    List<int> notifyDaysBefore,
  ) async {
    // Cancel any existing notifications for this reminder
    await cancelForReminder(reminder.id);

    for (var i = 0; i < notifyDaysBefore.length; i++) {
      final days = notifyDaysBefore[i];
      final fireDate = reminder.dueDate.subtract(Duration(days: days));

      // Skip if the fire date is in the past
      if (fireDate.isBefore(DateTime.now())) continue;

      final notifId =
          reminder.id * AppConstants.notificationIdRangePerReminder + i;

      final channelId = days == 0
          ? AppConstants.channelDueToday
          : AppConstants.channelUpcoming;

      final body = days == 0
          ? '${reminder.title} is due today!'
          : '${reminder.title} is due in $days day${days == 1 ? '' : 's'}.';

      try {
        await _plugin.zonedSchedule(
          notifId,
          'DueMate Reminder',
          body,
          tz.TZDateTime.from(fireDate, tz.local),
          NotificationDetails(
            android: AndroidNotificationDetails(
              channelId,
              channelId == AppConstants.channelDueToday
                  ? AppConstants.channelDueTodayName
                  : AppConstants.channelUpcomingName,
              importance: days == 0 ? Importance.high : Importance.defaultImportance,
              priority: Priority.high,
              category: AndroidNotificationCategory.reminder,
            ),
          ),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          payload: 'reminder:${reminder.id}',
        );
      } catch (e) {
        debugPrint('Failed to schedule notification $notifId: $e');
      }
    }
  }

  static Future<void> cancelForReminder(int reminderId) async {
    for (var i = 0; i < AppConstants.notificationIdRangePerReminder; i++) {
      await _plugin.cancel(
          reminderId * AppConstants.notificationIdRangePerReminder + i);
    }
  }

  static Future<void> cancelAll() => _plugin.cancelAll();

  static Future<bool> requestPermission() async {
    final android =
        _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    final granted = await android?.requestNotificationsPermission();
    return granted ?? false;
  }
}
