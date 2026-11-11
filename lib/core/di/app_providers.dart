import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/app_database.dart';
import '../database/daos/custom_categories_dao.dart';
import '../database/daos/notification_schedules_dao.dart';
import '../database/daos/reminders_dao.dart';

// Single shared database instance
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final remindersDaoProvider = Provider<RemindersDao>((ref) {
  return ref.watch(databaseProvider).remindersDao;
});

final notificationSchedulesDaoProvider =
    Provider<NotificationSchedulesDao>((ref) {
  return ref.watch(databaseProvider).notificationSchedulesDao;
});

final customCategoriesDaoProvider = Provider<CustomCategoriesDao>((ref) {
  return ref.watch(databaseProvider).customCategoriesDao;
});
