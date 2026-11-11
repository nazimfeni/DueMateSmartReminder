import '../entities/reminder.dart';

abstract interface class IRemindersRepository {
  Stream<List<Reminder>> watchAll();
  Future<List<Reminder>> getAll();
  Future<Reminder?> getById(int id);
  Future<int> save(Reminder reminder, List<int> notifyDaysBefore);
  Future<void> delete(int id);
  Future<void> markComplete(int id);
  Future<void> deleteAll();
  Future<List<Reminder>> getAllForBackup();
}
