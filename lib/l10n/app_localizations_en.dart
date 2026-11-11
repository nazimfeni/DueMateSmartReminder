// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'DueMate';

  @override
  String get remindersTitle => 'Reminders';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get addReminder => 'New Reminder';

  @override
  String get editReminder => 'Edit Reminder';

  @override
  String get titleLabel => 'Title';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get categoryLabel => 'Category';

  @override
  String get dueDateLabel => 'Due Date';

  @override
  String get amountLabel => 'Amount';

  @override
  String get currencyLabel => 'Currency';

  @override
  String get recurringLabel => 'Recurring';

  @override
  String get notifyBeforeLabel => 'Notify me before due date';

  @override
  String get saveButton => 'Save';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get deleteButton => 'Delete';

  @override
  String get confirmDeleteTitle => 'Delete Reminder';

  @override
  String get confirmDeleteMessage =>
      'This reminder and all its notification schedules will be permanently deleted.';

  @override
  String get categoryPayment => 'Payment';

  @override
  String get categoryDocument => 'Document';

  @override
  String get categorySubscription => 'Subscription';

  @override
  String get categoryWarranty => 'Warranty';

  @override
  String get statusDueToday => 'Due today';

  @override
  String statusOverdue(int days) {
    return 'Overdue by $days day(s)';
  }

  @override
  String statusUpcoming(int days) {
    return 'Due in $days day(s)';
  }

  @override
  String get statusCompleted => 'Completed';

  @override
  String get emptyStateTitle => 'No reminders yet';

  @override
  String get emptyStateSubtitle => 'Tap + to add your first reminder';

  @override
  String get backupTitle => 'Backup & Restore';

  @override
  String get exportJson => 'Export as JSON';

  @override
  String get exportCsv => 'Export as CSV';

  @override
  String get importMerge => 'Import & Merge';

  @override
  String get importReplace => 'Import & Replace';

  @override
  String get deleteAllData => 'Delete All Data';

  @override
  String get themeLabel => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get languageLabel => 'Language';

  @override
  String get privacyPolicyLabel => 'Privacy Policy';
}
