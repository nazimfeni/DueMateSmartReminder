import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/app_providers.dart';
import '../../data/repositories/reminders_repository_impl.dart';
import '../../domain/entities/reminder.dart';
import '../../domain/repositories/i_reminders_repository.dart';
import '../../domain/usecases/delete_reminder_usecase.dart';
import '../../domain/usecases/get_all_reminders_usecase.dart';
import '../../domain/usecases/mark_complete_usecase.dart';
import '../../domain/usecases/save_reminder_usecase.dart';

final remindersRepositoryProvider = Provider<IRemindersRepository>((ref) {
  return RemindersRepositoryImpl(
    remindersDao: ref.watch(remindersDaoProvider),
    schedulesDao: ref.watch(notificationSchedulesDaoProvider),
  );
});

final getAllRemindersUseCaseProvider = Provider<GetAllRemindersUseCase>((ref) {
  return GetAllRemindersUseCase(ref.watch(remindersRepositoryProvider));
});

final saveReminderUseCaseProvider = Provider<SaveReminderUseCase>((ref) {
  return SaveReminderUseCase(ref.watch(remindersRepositoryProvider));
});

final deleteReminderUseCaseProvider = Provider<DeleteReminderUseCase>((ref) {
  return DeleteReminderUseCase(ref.watch(remindersRepositoryProvider));
});

final markCompleteUseCaseProvider = Provider<MarkCompleteUseCase>((ref) {
  return MarkCompleteUseCase(ref.watch(remindersRepositoryProvider));
});

// Live stream of all reminders
final allRemindersProvider = StreamProvider<List<Reminder>>((ref) {
  return ref.watch(getAllRemindersUseCaseProvider).call();
});

// Active category filter (stores category name string, e.g. 'payment', or null for All)
final categoryFilterProvider = StateProvider<String?>((ref) => null);

// Filtered reminders derived from the live stream + filter
final filteredRemindersProvider = Provider<AsyncValue<List<Reminder>>>((ref) {
  final allAsync = ref.watch(allRemindersProvider);
  final filter = ref.watch(categoryFilterProvider);

  return allAsync.whenData((reminders) {
    if (filter == null) return reminders;
    return reminders.where((r) => r.category == filter).toList();
  });
});

// Single reminder by id (for detail / edit screens)
final reminderByIdProvider =
    FutureProvider.family<Reminder?, int>((ref, id) {
  return ref.watch(remindersRepositoryProvider).getById(id);
});
