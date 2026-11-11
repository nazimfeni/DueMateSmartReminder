import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/di/app_providers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/reminder_category.dart';

/// A unified representation of a reminder category — either built-in or custom.
class CategoryOption {
  const CategoryOption({
    required this.name,
    required this.color,
    required this.label,
    required this.isBuiltIn,
  });

  final String name;
  final Color color;
  final String label;
  final bool isBuiltIn;
}

/// Stream of all custom category records from the database.
final customCategoriesProvider =
    StreamProvider<List<CustomCategoryRecord>>((ref) {
  return ref.watch(customCategoriesDaoProvider).watchAll();
});

/// Built-in categories mapped to [CategoryOption].
final _builtInOptions = ReminderCategory.values.map((cat) {
  Color color;
  switch (cat) {
    case ReminderCategory.payment:
      color = AppColors.payment;
    case ReminderCategory.document:
      color = AppColors.document;
    case ReminderCategory.subscription:
      color = AppColors.subscription;
    case ReminderCategory.warranty:
      color = AppColors.warranty;
  }
  return CategoryOption(
    name: cat.name,
    color: color,
    label: cat.label,
    isBuiltIn: true,
  );
}).toList();

/// Combined list of built-in + custom [CategoryOption]s.
final categoryOptionsProvider = Provider<List<CategoryOption>>((ref) {
  final customAsync = ref.watch(customCategoriesProvider);

  final customOptions = customAsync.maybeWhen(
    data: (records) => records
        .map((r) => CategoryOption(
              name: r.name,
              color: Color(r.colorValue),
              label: r.name,
              isBuiltIn: false,
            ))
        .toList(),
    orElse: () => <CategoryOption>[],
  );

  return [..._builtInOptions, ...customOptions];
});
