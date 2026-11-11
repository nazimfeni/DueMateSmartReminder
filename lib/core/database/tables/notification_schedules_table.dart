import 'package:drift/drift.dart';

import 'reminders_table.dart';

@DataClassName('NotificationScheduleRecord')
class NotificationSchedulesTable extends Table {
  @override
  String get tableName => 'notification_schedules';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get reminderId => integer().references(
        RemindersTable,
        #id,
        onDelete: KeyAction.cascade,
      )();

  /// Days before dueDate to fire this notification
  IntColumn get daysBefore => integer()();

  /// Unique Android notification ID for this schedule
  IntColumn get notificationId => integer().unique()();

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}
