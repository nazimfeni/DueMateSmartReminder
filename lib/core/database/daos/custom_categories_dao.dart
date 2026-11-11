import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/custom_categories_table.dart';

part 'custom_categories_dao.g.dart';

@DriftAccessor(tables: [CustomCategoriesTable])
class CustomCategoriesDao extends DatabaseAccessor<AppDatabase>
    with _$CustomCategoriesDaoMixin {
  CustomCategoriesDao(super.db);

  Stream<List<CustomCategoryRecord>> watchAll() {
    return (select(customCategoriesTable)
          ..orderBy([(t) => OrderingTerm(expression: t.name)]))
        .watch();
  }

  Future<int> insert(String name, int colorValue) =>
      into(customCategoriesTable).insert(
        CustomCategoriesTableCompanion.insert(
          name: name,
          colorValue: colorValue,
        ),
      );

  Future<int> deleteById(int id) =>
      (delete(customCategoriesTable)..where((t) => t.id.equals(id))).go();
}
