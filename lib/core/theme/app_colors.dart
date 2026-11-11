import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand
  static const Color primary = Color(0xFF1565C0); // Deep blue
  static const Color primaryVariant = Color(0xFF0D47A1);
  static const Color secondary = Color(0xFFFF6F00); // Amber — urgency/due dates
  static const Color secondaryVariant = Color(0xFFE65100);

  // Status
  static const Color overdue = Color(0xFFD32F2F);
  static const Color dueToday = Color(0xFFFF6F00);
  static const Color upcoming = Color(0xFF388E3C);
  static const Color completed = Color(0xFF757575);

  // Category
  static const Color payment = Color(0xFF1565C0);
  static const Color document = Color(0xFF7B1FA2);
  static const Color subscription = Color(0xFF00838F);
  static const Color warranty = Color(0xFF2E7D32);

  // Neutral
  static const Color surfaceLight = Color(0xFFF8FAFC);
  static const Color surfaceDark = Color(0xFF1A1C1E);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF2B2D30);
}
