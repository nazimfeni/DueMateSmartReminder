import 'package:drift/drift.dart';

@DataClassName('CustomCategoryRecord')
class CustomCategoriesTable extends Table {
  @override
  String get tableName => 'custom_categories';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  IntColumn get colorValue => integer()();
}
