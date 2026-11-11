import 'package:drift/drift.dart';

@DataClassName('ReminderRecord')
class RemindersTable extends Table {
  @override
  String get tableName => 'reminders';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text().unique()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();

  /// One of: payment, document, subscription, warranty
  TextColumn get category => text()();

  DateTimeColumn get dueDate => dateTime()();
  RealColumn get amount => real().nullable()();
  TextColumn get currencyCode => text().withDefault(const Constant('BDT'))();

  BoolColumn get isRecurring =>
      boolean().withDefault(const Constant(false))();

  /// One of: daily, weekly, monthly, yearly — null when not recurring
  TextColumn get recurrenceType => text().nullable()();

  /// How many units of recurrenceType between occurrences
  IntColumn get recurrenceInterval => integer().nullable()();

  BoolColumn get isCompleted =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
