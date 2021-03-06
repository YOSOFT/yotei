import 'package:laplanche/data/app_database.dart';
import 'package:laplanche/model/board_category.dart';
import 'package:moor/moor.dart';

part 'category_dao.g.dart';

@UseDao(tables: [BoardCategory])
class CategoryDao extends DatabaseAccessor<AppDatabase>
    with _$CategoryDaoMixin {
  CategoryDao(AppDatabase appDatabase) : super(appDatabase);

  Future<List<BoardCategoryData>> getAllCategory() =>
      select(boardCategory).get();
  Stream<List<BoardCategoryData>> watchAllCategory() =>
      select(boardCategory).watch();

  Future<int> insertCategory(String categoryName) async {
    BoardCategoryData cat = await findByIdName(categoryName);
    if (cat != null) {
      return cat.id;
    }
    BoardCategoryData category =
        BoardCategoryData(id: null, name: categoryName);
    await into(boardCategory).insert(category);
    return insertCategory(categoryName);
  }

  Future<BoardCategoryData> findByIdName(String name) {
    return (select(boardCategory)..where((t) => t.name.like(name))).getSingle();
  }

  Future updateCategory(BoardCategoryData c) =>
      update(boardCategory).replace(c);

  Future deleteCategoryById(int categoryId) {
    var res =
        (delete(boardCategory)..where((tbl) => tbl.id.equals(categoryId))).go();
    return res;
  }

  Future deleteCategory(BoardCategoryData c) => delete(boardCategory).delete(c);
}
