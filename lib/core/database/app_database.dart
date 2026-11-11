import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'daos/custom_categories_dao.dart';
import 'daos/notification_schedules_dao.dart';
import 'daos/reminders_dao.dart';
import 'tables/custom_categories_table.dart';
import 'tables/notification_schedules_table.dart';
import 'tables/reminders_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [RemindersTable, NotificationSchedulesTable, CustomCategoriesTable],
  daos: [RemindersDao, NotificationSchedulesDao, CustomCategoriesDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(customCategoriesTable);
          }
        },
        beforeOpen: (details) async {
          // Enable FK constraints — SQLite has them off by default
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      final file = File(p.join(dir.path, 'duemate.sqlite'));
      return NativeDatabase.createInBackground(file);
    });
  }
}
