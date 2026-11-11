import 'notification_schedule.dart';
import 'recurrence_type.dart';

class Reminder {
  const Reminder({
    required this.id,
    required this.uuid,
    required this.title,
    required this.category,
    required this.dueDate,
    required this.createdAt,
    required this.updatedAt,
    this.description,
    this.amount,
    this.currencyCode = 'BDT',
    this.isRecurring = false,
    this.recurrenceType,
    this.recurrenceInterval,
    this.isCompleted = false,
    this.completedAt,
    this.notificationSchedules = const [],
  });

  final int id;
  final String uuid;
  final String title;
  final String? description;
  final String category;
  final DateTime dueDate;
  final double? amount;
  final String currencyCode;
  final bool isRecurring;
  final RecurrenceType? recurrenceType;
  final int? recurrenceInterval;
  final bool isCompleted;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<NotificationSchedule> notificationSchedules;

  bool get isOverdue =>
      !isCompleted && dueDate.isBefore(DateTime.now());

  bool get isDueToday {
    final now = DateTime.now();
    return !isCompleted &&
        dueDate.year == now.year &&
        dueDate.month == now.month &&
        dueDate.day == now.day;
  }

  int get daysUntilDue =>
      dueDate.difference(DateTime.now()).inDays;

  Reminder copyWith({
    int? id,
    String? uuid,
    String? title,
    String? description,
    String? category,
    DateTime? dueDate,
    double? amount,
    String? currencyCode,
    bool? isRecurring,
    RecurrenceType? recurrenceType,
    int? recurrenceInterval,
    bool? isCompleted,
    DateTime? completedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<NotificationSchedule>? notificationSchedules,
  }) {
    return Reminder(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      dueDate: dueDate ?? this.dueDate,
      amount: amount ?? this.amount,
      currencyCode: currencyCode ?? this.currencyCode,
      isRecurring: isRecurring ?? this.isRecurring,
      recurrenceType: recurrenceType ?? this.recurrenceType,
      recurrenceInterval: recurrenceInterval ?? this.recurrenceInterval,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notificationSchedules:
          notificationSchedules ?? this.notificationSchedules,
    );
  }
}
