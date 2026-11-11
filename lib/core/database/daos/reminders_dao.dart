import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/reminders_table.dart';

part 'reminders_dao.g.dart';

@DriftAccessor(tables: [RemindersTable])
class RemindersDao extends DatabaseAccessor<AppDatabase>
    with _$RemindersDaoMixin {
  RemindersDao(super.db);

  Stream<List<ReminderRecord>> watchAll() {
    return (select(remindersTable)
          ..orderBy([(t) => OrderingTerm(expression: t.dueDate)]))
        .watch();
  }

  Future<List<ReminderRecord>> getAll() =>
      (select(remindersTable)
            ..orderBy([(t) => OrderingTerm(expression: t.dueDate)]))
          .get();

  Future<ReminderRecord?> getById(int id) =>
      (select(remindersTable)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<ReminderRecord?> getByUuid(String uuid) =>
      (select(remindersTable)..where((t) => t.uuid.equals(uuid)))
          .getSingleOrNull();

  Future<int> insert(RemindersTableCompanion entry) =>
      into(remindersTable).insert(entry);

  Future<bool> updateEntry(RemindersTableCompanion entry) =>
      update(remindersTable).replace(entry);

  Future<int> deleteById(int id) =>
      (delete(remindersTable)..where((t) => t.id.equals(id))).go();

  Future<int> deleteAll() => delete(remindersTable).go();

  Stream<List<ReminderRecord>> watchByCategory(String category) {
    return (select(remindersTable)
          ..where((t) => t.category.equals(category))
          ..orderBy([(t) => OrderingTerm(expression: t.dueDate)]))
        .watch();
  }

  Future<List<ReminderRecord>> getOverdue(DateTime now) {
    return (select(remindersTable)
          ..where((t) =>
              t.dueDate.isSmallerThanValue(now) &
              t.isCompleted.equals(false)))
        .get();
  }

  Future<List<ReminderRecord>> getDueWithin(DateTime from, DateTime to) {
    return (select(remindersTable)
          ..where((t) =>
              t.dueDate.isBetweenValues(from, to) &
              t.isCompleted.equals(false)))
        .get();
  }
}
