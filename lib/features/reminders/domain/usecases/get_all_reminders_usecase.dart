import '../entities/reminder.dart';
import '../repositories/i_reminders_repository.dart';

class GetAllRemindersUseCase {
  const GetAllRemindersUseCase(this._repository);

  final IRemindersRepository _repository;

  Stream<List<Reminder>> call() => _repository.watchAll();
}
