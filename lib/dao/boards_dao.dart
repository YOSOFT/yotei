import 'package:laplanche/data/app_database.dart';
import 'package:moor/moor.dart';
import 'package:laplanche/model/boards.dart';

part 'boards_dao.g.dart';

@UseDao(tables: [Boards])
class BoardsDao extends DatabaseAccessor<AppDatabase> with _$BoardsDaoMixin {
  BoardsDao(AppDatabase appDatabase) : super(appDatabase);

  Future<List<Board>> getAllBoards() => select(boards).get();
  Stream<List<Board>> watchAllBoards() => select(boards).watch();
  Future insertBoard(Board b) {
    var s = into(boards).insert(b);
    return s;
  }

  Future updateboard(Board b) => update(boards).replace(b);
  Future deleteBoard(Board b) => delete(boards).delete(b);
}
