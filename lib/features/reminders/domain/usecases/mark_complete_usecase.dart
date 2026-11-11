import '../repositories/i_reminders_repository.dart';

class MarkCompleteUseCase {
  const MarkCompleteUseCase(this._repository);

  final IRemindersRepository _repository;

  Future<void> call(int id) => _repository.markComplete(id);
}
