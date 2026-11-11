enum RecurrenceType {
  daily,
  weekly,
  monthly,
  yearly;

  String get label {
    switch (this) {
      case RecurrenceType.daily:
        return 'Daily';
      case RecurrenceType.weekly:
        return 'Weekly';
      case RecurrenceType.monthly:
        return 'Monthly';
      case RecurrenceType.yearly:
        return 'Yearly';
    }
  }

  static RecurrenceType? fromString(String? value) {
    if (value == null) return null;
    return RecurrenceType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => RecurrenceType.monthly,
    );
  }
}
