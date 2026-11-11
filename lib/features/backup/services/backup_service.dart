import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constants/app_constants.dart';
import '../../reminders/domain/entities/reminder.dart';
import '../../reminders/domain/repositories/i_reminders_repository.dart';

class BackupService {
  const BackupService(this._repository);

  final IRemindersRepository _repository;

  // ---------------------------------------------------------------------------
  // Export
  // ---------------------------------------------------------------------------

  Future<bool> exportJson() async {
    try {
      final reminders = await _repository.getAllForBackup();
      final json = _buildJsonPayload(reminders);
      final encoded = const JsonEncoder.withIndent('  ').convert(json);

      final fileName =
          '${AppConstants.backupFilePrefix}_${_timestamp()}${AppConstants.backupJsonExtension}';

      // Write to temp file and share via system share sheet / SAF
      final tempDir = Directory.systemTemp;
      final file = File('${tempDir.path}/$fileName');
      await file.writeAsString(encoded);
      await SharePlus.instance.share(ShareParams(files: [XFile(file.path)], text: 'DueMate backup'));
      return true;
    } catch (e) {
      debugPrint('Export failed: $e');
      return false;
    }
  }

  Future<bool> exportCsv() async {
    try {
      final reminders = await _repository.getAllForBackup();
      final csv = _buildCsv(reminders);

      final fileName =
          '${AppConstants.backupFilePrefix}_${_timestamp()}${AppConstants.backupCsvExtension}';

      final tempDir = Directory.systemTemp;
      final file = File('${tempDir.path}/$fileName');
      await file.writeAsString(csv);
      await SharePlus.instance.share(ShareParams(files: [XFile(file.path)], text: 'DueMate CSV export'));
      return true;
    } catch (e) {
      debugPrint('CSV export failed: $e');
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // Import
  // ---------------------------------------------------------------------------

  Future<ImportResult> importJson({bool merge = false}) async {
    try {
      final file = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );
      if (file == null) {
        return ImportResult.cancelled();
      }

      final bytes = await file.readAsBytes();
      final raw = utf8.decode(bytes);
      final json = jsonDecode(raw) as Map<String, dynamic>;

      if (!_validateBackup(json)) {
        return ImportResult.error('Invalid or incompatible backup file');
      }

      final reminders = _parseReminders(json);

      if (!merge) {
        await _repository.deleteAll();
      }

      for (final r in reminders) {
        final notifyDays =
            r.notificationSchedules.map((s) => s.daysBefore).toList();
        await _repository.save(r, notifyDays);
      }

      return ImportResult.success(reminders.length);
    } catch (e) {
      debugPrint('Import failed: $e');
      return ImportResult.error('Import failed: $e');
    }
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  Map<String, dynamic> _buildJsonPayload(List<Reminder> reminders) {
    return {
      'version': AppConstants.backupVersion,
      'exportedAt': DateTime.now().toIso8601String(),
      'count': reminders.length,
      'reminders': reminders.map((r) => {
            'uuid': r.uuid,
            'title': r.title,
            'description': r.description,
            'category': r.category,
            'dueDate': r.dueDate.toIso8601String(),
            'amount': r.amount,
            'currencyCode': r.currencyCode,
            'isRecurring': r.isRecurring,
            'recurrenceType': r.recurrenceType?.name,
            'recurrenceInterval': r.recurrenceInterval,
            'isCompleted': r.isCompleted,
            'completedAt': r.completedAt?.toIso8601String(),
            'createdAt': r.createdAt.toIso8601String(),
            'notifyDaysBefore': r.notificationSchedules
                .map((s) => s.daysBefore)
                .toList(),
          }).toList(),
    };
  }

  String _buildCsv(List<Reminder> reminders) {
    final buffer = StringBuffer();
    buffer.writeln(
        'UUID,Title,Category,DueDate,Amount,Currency,IsRecurring,IsCompleted');
    for (final r in reminders) {
      buffer.writeln([
        r.uuid,
        '"${r.title.replaceAll('"', '""')}"',
        r.category,
        r.dueDate.toIso8601String(),
        r.amount ?? '',
        r.currencyCode,
        r.isRecurring,
        r.isCompleted,
      ].join(','));
    }
    return buffer.toString();
  }

  bool _validateBackup(Map<String, dynamic> json) {
    return json.containsKey('version') &&
        json.containsKey('reminders') &&
        json['reminders'] is List;
  }

  List<Reminder> _parseReminders(Map<String, dynamic> json) {
    final list = json['reminders'] as List;
    return list.whereType<Map<String, dynamic>>().map((m) {
      return Reminder(
        id: 0,
        uuid: m['uuid'] as String? ?? '',
        title: m['title'] as String,
        description: m['description'] as String?,
        category: m['category'] as String? ?? 'payment',
        dueDate: DateTime.parse(m['dueDate'] as String),
        amount: (m['amount'] as num?)?.toDouble(),
        currencyCode: m['currencyCode'] as String? ?? 'BDT',
        isRecurring: m['isRecurring'] as bool? ?? false,
        isCompleted: m['isCompleted'] as bool? ?? false,
        completedAt: m['completedAt'] != null
            ? DateTime.tryParse(m['completedAt'] as String)
            : null,
        createdAt: m['createdAt'] != null
            ? DateTime.tryParse(m['createdAt'] as String) ?? DateTime.now()
            : DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }).toList();
  }

  String _timestamp() {
    final now = DateTime.now();
    return '${now.year}${now.month.toString().padLeft(2, '0')}'
        '${now.day.toString().padLeft(2, '0')}'
        '_${now.hour.toString().padLeft(2, '0')}'
        '${now.minute.toString().padLeft(2, '0')}';
  }
}

class ImportResult {
  const ImportResult._({
    required this.success,
    this.count,
    this.error,
    this.cancelled = false,
  });

  factory ImportResult.success(int count) =>
      ImportResult._(success: true, count: count);
  factory ImportResult.error(String msg) =>
      ImportResult._(success: false, error: msg);
  factory ImportResult.cancelled() =>
      const ImportResult._(success: false, cancelled: true);

  final bool success;
  final int? count;
  final String? error;
  final bool cancelled;
}
