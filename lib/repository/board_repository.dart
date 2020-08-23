import 'package:laplanche/data/app_database.dart';
import 'package:laplanche/model/board_with_category.dart';

class BoardRepository {
  final categoryDao = AppDatabase().categoryDao;
  final boardDao = AppDatabase().boardsDao;

  Future<List<Board>> getAllBoard() {
    return boardDao.getAllBoards();
  }

  Future<List<BoardWithCategory>> getAllBoardWithCategory() {
    return boardDao.getAllBoardWithCategory();
  }

  Future<int> create(Board board, String categoryName) async {
    int categoryId = await categoryDao.insertCategory(categoryName);
    board = board.copyWith(category: categoryId);
    var result = await boardDao.insertBoard(board);
    return result;
  }
}
