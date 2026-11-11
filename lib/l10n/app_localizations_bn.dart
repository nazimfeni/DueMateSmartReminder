// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appName => 'DueMate';

  @override
  String get remindersTitle => 'রিমাইন্ডার';

  @override
  String get settingsTitle => 'সেটিংস';

  @override
  String get addReminder => 'নতুন রিমাইন্ডার';

  @override
  String get editReminder => 'রিমাইন্ডার সম্পাদনা';

  @override
  String get titleLabel => 'শিরোনাম';

  @override
  String get descriptionLabel => 'বিবরণ';

  @override
  String get categoryLabel => 'বিভাগ';

  @override
  String get dueDateLabel => 'নির্ধারিত তারিখ';

  @override
  String get amountLabel => 'পরিমাণ';

  @override
  String get currencyLabel => 'মুদ্রা';

  @override
  String get recurringLabel => 'পুনরাবৃত্তি';

  @override
  String get notifyBeforeLabel => 'নির্ধারিত তারিখের আগে জানান';

  @override
  String get saveButton => 'সংরক্ষণ করুন';

  @override
  String get cancelButton => 'বাতিল';

  @override
  String get deleteButton => 'মুছুন';

  @override
  String get confirmDeleteTitle => 'রিমাইন্ডার মুছুন';

  @override
  String get confirmDeleteMessage =>
      'এই রিমাইন্ডার এবং এর সমস্ত নোটিফিকেশন সময়সূচী স্থায়ীভাবে মুছে যাবে।';

  @override
  String get categoryPayment => 'পেমেন্ট';

  @override
  String get categoryDocument => 'ডকুমেন্ট';

  @override
  String get categorySubscription => 'সাবস্ক্রিপশন';

  @override
  String get categoryWarranty => 'ওয়ারেন্টি';

  @override
  String get statusDueToday => 'আজ মেয়াদ শেষ';

  @override
  String statusOverdue(int days) {
    return '$days দিন আগে মেয়াদ শেষ';
  }

  @override
  String statusUpcoming(int days) {
    return '$days দিনের মধ্যে মেয়াদ শেষ';
  }

  @override
  String get statusCompleted => 'সম্পন্ন';

  @override
  String get emptyStateTitle => 'এখনো কোনো রিমাইন্ডার নেই';

  @override
  String get emptyStateSubtitle => 'প্রথম রিমাইন্ডার যোগ করতে + ট্যাপ করুন';

  @override
  String get backupTitle => 'ব্যাকআপ ও পুনরুদ্ধার';

  @override
  String get exportJson => 'JSON হিসেবে এক্সপোর্ট';

  @override
  String get exportCsv => 'CSV হিসেবে এক্সপোর্ট';

  @override
  String get importMerge => 'ইম্পোর্ট ও মার্জ করুন';

  @override
  String get importReplace => 'ইম্পোর্ট ও প্রতিস্থাপন করুন';

  @override
  String get deleteAllData => 'সমস্ত ডেটা মুছুন';

  @override
  String get themeLabel => 'থিম';

  @override
  String get themeSystem => 'সিস্টেম';

  @override
  String get themeLight => 'লাইট';

  @override
  String get themeDark => 'ডার্ক';

  @override
  String get languageLabel => 'ভাষা';

  @override
  String get privacyPolicyLabel => 'গোপনীয়তা নীতি';
}
