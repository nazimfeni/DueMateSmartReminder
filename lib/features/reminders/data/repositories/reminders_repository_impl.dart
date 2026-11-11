import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/notification_schedules_dao.dart';
import '../../../../core/database/daos/reminders_dao.dart';
import '../../domain/entities/reminder.dart';
import '../../domain/repositories/i_reminders_repository.dart';
import '../mappers/reminder_mapper.dart';

class RemindersRepositoryImpl implements IRemindersRepository {
  // ignore: prefer_initializing_formals
  RemindersRepositoryImpl({
    required RemindersDao remindersDao,
    required NotificationSchedulesDao schedulesDao,
  })  : _remindersDao = remindersDao,
        _schedulesDao = schedulesDao;

  final RemindersDao _remindersDao;
  final NotificationSchedulesDao _schedulesDao;
  final _uuid = const Uuid();

  @override
  Stream<List<Reminder>> watchAll() {
    return _remindersDao.watchAll().asyncMap(_attachSchedules);
  }

  @override
  Future<List<Reminder>> getAll() async {
    final records = await _remindersDao.getAll();
    return _attachSchedules(records);
  }

  @override
  Future<Reminder?> getById(int id) async {
    final record = await _remindersDao.getById(id);
    if (record == null) return null;
    final schedules = await _schedulesDao.getByReminderId(id);
    return record.toDomain(schedules: schedules);
  }

  @override
  Future<int> save(Reminder reminder, List<int> notifyDaysBefore) async {
    final isNew = reminder.id == 0;

    final companion = isNew
        ? RemindersTableCompanion.insert(
            uuid: reminder.uuid.isEmpty ? _uuid.v4() : reminder.uuid,
            title: reminder.title,
            description: Value(reminder.description),
            category: reminder.category,
            dueDate: reminder.dueDate,
            amount: Value(reminder.amount),
            currencyCode: Value(reminder.currencyCode),
            isRecurring: Value(reminder.isRecurring),
            recurrenceType: Value(reminder.recurrenceType?.name),
            recurrenceInterval: Value(reminder.recurrenceInterval),
          )
        : reminder.toCompanion();

    final int savedId;
    if (isNew) {
      savedId = await _remindersDao.insert(companion);
    } else {
      await _remindersDao.updateEntry(companion);
      savedId = reminder.id;
    }

    // Replace notification schedules
    await _schedulesDao.deleteByReminderId(savedId);
    final scheduleEntries = notifyDaysBefore.asMap().entries.map((e) {
      final notifId = savedId * AppConstants.notificationIdRangePerReminder + e.key;
      return notificationScheduleCompanion(
        reminderId: savedId,
        daysBefore: e.value,
        notificationId: notifId,
      );
    }).toList();
    await _schedulesDao.insertAll(scheduleEntries);

    return savedId;
  }

  @override
  Future<void> delete(int id) => _remindersDao.deleteById(id);

  @override
  Future<void> markComplete(int id) async {
    final record = await _remindersDao.getById(id);
    if (record == null) return;
    await _remindersDao.updateEntry(
      record.toDomain().copyWith(
        isCompleted: true,
        completedAt: DateTime.now(),
      ).toCompanion(),
    );
  }

  @override
  Future<void> deleteAll() async {
    await _schedulesDao.deleteAll();
    await _remindersDao.deleteAll();
  }

  @override
  Future<List<Reminder>> getAllForBackup() => getAll();

  Future<List<Reminder>> _attachSchedules(
      List<ReminderRecord> records) async {
    return Future.wait(records.map((r) async {
      final schedules = await _schedulesDao.getByReminderId(r.id);
      return r.toDomain(schedules: schedules);
    }));
  }
}
