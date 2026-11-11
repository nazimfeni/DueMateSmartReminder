abstract final class AppConstants {
  static const String appName = 'DueMate';
  static const String packageName = 'com.fincrit.smartreminder';
  static const String dbName = 'duemate.sqlite';
  static const String backupFilePrefix = 'duemate_backup';
  static const String backupJsonExtension = '.json';
  static const String backupCsvExtension = '.csv';
  static const String backupVersion = '1.0';

  // Notification channel IDs
  static const String channelDueToday = 'due_today';
  static const String channelUpcoming = 'upcoming';
  static const String channelOverdue = 'overdue';

  // Notification channel names
  static const String channelDueTodayName = 'Due Today';
  static const String channelUpcomingName = 'Upcoming Reminders';
  static const String channelOverdueName = 'Overdue Reminders';

  // Default notification schedule (days before due date)
  static const List<int> defaultNotificationDays = [7, 3, 1];

  // Max notification ID range per reminder (to avoid collisions)
  static const int notificationIdRangePerReminder = 10;

  // Supported currencies
  static const String defaultCurrency = 'BDT';
  static const List<String> supportedCurrencies = ['BDT', 'USD', 'EUR', 'GBP', 'INR'];
}
