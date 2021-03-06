import 'package:laplanche/data/app_database.dart';
import 'package:laplanche/model/board_category.dart';
import 'package:laplanche/model/board_with_category.dart';
import 'package:moor/moor.dart';
import 'package:laplanche/model/boards.dart';

part 'boards_dao.g.dart';

@UseDao(tables: [Boards, BoardCategory])
class BoardsDao extends DatabaseAccessor<AppDatabase> with _$BoardsDaoMixin {
  BoardsDao(AppDatabase appDatabase) : super(appDatabase);

  Future<List<Board>> getAllBoards() => select(boards).get();
  Stream<List<Board>> watchAllBoards() => select(boards).watch();
  Future insertBoard(Board b) {
    var s = into(boards).insert(b);
    return s;
  }

  Stream<List<BoardWithCategory>> watchAllBoardWithCategory() {
    final query = select(boards).join([
      leftOuterJoin(boardCategory, boardCategory.id.equalsExp(boards.category))
    ]);
    return query.watch().map((rows) {
      return rows.map((row) {
        return BoardWithCategory(
          row.readTable(boards),
          row.readTable(boardCategory),
        );
      }).toList();
    });
  }

  Future<List<BoardWithCategory>> getAllBoardWithCategory() {
    return (select(boards)..orderBy([(clauses) => 
      OrderingTerm(
        expression: clauses.lastUpdated,
        mode: OrderingMode.desc
      ) 
    
    ])).join([
      leftOuterJoin(boardCategory, boardCategory.id.equalsExp(boards.category))
    ]).map((rows) {
      return BoardWithCategory(
        rows.readTable(boards),
        rows.readTable(boardCategory),
      );
    }).get();
  }

  Future<List<BoardWithCategory>> search(String q) {
    return (select(boards)..where((tbl) => tbl.name.like("%"+q+"%"))).join([
      leftOuterJoin(boardCategory, boardCategory.id.equalsExp(boards.category))
    ]).map((rows) {
      return BoardWithCategory(
          rows.readTable(boards), rows.readTable(boardCategory));
    }).get();
  }

  Future<BoardWithCategory> getSingleBoardWithCategory(Board b) async {
    Board result =
        await (select(boards)..where((tbl) => tbl.id.equals(b.id))).getSingle();
    BoardCategoryData category = await (select(boardCategory)
          ..where((tbl) => tbl.id.equals(b.category)))
        .getSingle();
    return BoardWithCategory(result, category);
  }

  Future<List<Board>> getAllBoardByCategoryId(int categoryId) {
    return (select(boards)..where((tbl) => tbl.category.equals(categoryId)))
        .get();
  }

  Future updateboard(Board b) {
    var result = (update(boards)..where((t) => t.id.equals(b.id))).write(
      BoardsCompanion(
        name: Value(b.name),
        description: Value(b.description),
        category: Value(b.category)
      ),
    );
    return result;
  }

  Future updateboardDate(Board b) {
    var result = (update(boards)..where((t) => t.id.equals(b.id))).write(
      BoardsCompanion(
        lastUpdated: Value(b.lastUpdated)
      ),
    );
    return result;
    // update(boards).replace(b)
  }

  Future deleteBoard(Board b) => delete(boards).delete(b);
}
