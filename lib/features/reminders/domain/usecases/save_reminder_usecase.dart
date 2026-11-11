import '../entities/reminder.dart';
import '../repositories/i_reminders_repository.dart';

class SaveReminderUseCase {
  const SaveReminderUseCase(this._repository);

  final IRemindersRepository _repository;

  Future<int> call(Reminder reminder, List<int> notifyDaysBefore) =>
      _repository.save(reminder, notifyDaysBefore);
}
