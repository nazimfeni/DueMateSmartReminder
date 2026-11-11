enum ReminderCategory {
  payment,
  document,
  subscription,
  warranty;

  String get label {
    switch (this) {
      case ReminderCategory.payment:
        return 'Payment';
      case ReminderCategory.document:
        return 'Document';
      case ReminderCategory.subscription:
        return 'Subscription';
      case ReminderCategory.warranty:
        return 'Warranty';
    }
  }

  static ReminderCategory fromString(String value) {
    return ReminderCategory.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ReminderCategory.payment,
    );
  }
}
