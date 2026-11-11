import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/notification_schedules_table.dart';

part 'notification_schedules_dao.g.dart';

@DriftAccessor(tables: [NotificationSchedulesTable])
class NotificationSchedulesDao extends DatabaseAccessor<AppDatabase>
    with _$NotificationSchedulesDaoMixin {
  NotificationSchedulesDao(super.db);

  Future<List<NotificationScheduleRecord>> getByReminderId(int reminderId) =>
      (select(notificationSchedulesTable)
            ..where((t) => t.reminderId.equals(reminderId)))
          .get();

  Future<int> insert(NotificationSchedulesTableCompanion entry) =>
      into(notificationSchedulesTable).insert(entry);

  Future<void> insertAll(
      List<NotificationSchedulesTableCompanion> entries) async {
    await batch((b) => b.insertAll(notificationSchedulesTable, entries));
  }

  Future<int> deleteByReminderId(int reminderId) =>
      (delete(notificationSchedulesTable)
            ..where((t) => t.reminderId.equals(reminderId)))
          .go();

  Future<int> deleteAll() => delete(notificationSchedulesTable).go();

  Future<List<NotificationScheduleRecord>> getAllActive() =>
      (select(notificationSchedulesTable)
            ..where((t) => t.isActive.equals(true)))
          .get();
}
