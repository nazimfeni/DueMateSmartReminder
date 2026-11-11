import '../repositories/i_reminders_repository.dart';

class DeleteReminderUseCase {
  const DeleteReminderUseCase(this._repository);

  final IRemindersRepository _repository;

  Future<void> call(int id) => _repository.delete(id);
}
