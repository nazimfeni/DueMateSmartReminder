import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/notification_schedule.dart';
import '../../domain/entities/reminder.dart';
import '../../domain/entities/recurrence_type.dart';

extension ReminderRecordMapper on ReminderRecord {
  Reminder toDomain({List<NotificationScheduleRecord> schedules = const []}) {
    return Reminder(
      id: id,
      uuid: uuid,
      title: title,
      description: description,
      category: category,
      dueDate: dueDate,
      amount: amount,
      currencyCode: currencyCode,
      isRecurring: isRecurring,
      recurrenceType: RecurrenceType.fromString(recurrenceType),
      recurrenceInterval: recurrenceInterval,
      isCompleted: isCompleted,
      completedAt: completedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      notificationSchedules: schedules.map((s) => s.toDomain()).toList(),
    );
  }
}

extension NotificationScheduleRecordMapper on NotificationScheduleRecord {
  NotificationSchedule toDomain() {
    return NotificationSchedule(
      id: id,
      reminderId: reminderId,
      daysBefore: daysBefore,
      notificationId: notificationId,
      isActive: isActive,
    );
  }
}

extension ReminderToCompanion on Reminder {
  RemindersTableCompanion toCompanion({bool insert = false}) {
    return RemindersTableCompanion(
      id: insert ? const Value.absent() : Value(id),
      uuid: Value(uuid),
      title: Value(title),
      description: Value(description),
      category: Value(category),
      dueDate: Value(dueDate),
      amount: Value(amount),
      currencyCode: Value(currencyCode),
      isRecurring: Value(isRecurring),
      recurrenceType: Value(recurrenceType?.name),
      recurrenceInterval: Value(recurrenceInterval),
      isCompleted: Value(isCompleted),
      completedAt: Value(completedAt),
      updatedAt: Value(DateTime.now()),
    );
  }
}

NotificationSchedulesTableCompanion notificationScheduleCompanion({
  required int reminderId,
  required int daysBefore,
  required int notificationId,
}) {
  return NotificationSchedulesTableCompanion.insert(
    reminderId: reminderId,
    daysBefore: daysBefore,
    notificationId: notificationId,
  );
}
