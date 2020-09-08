import 'package:laplanche/data/app_database.dart';
import 'package:laplanche/model/board_with_category.dart';

class BoardRepository {
  final AppDatabase _appDb;
  BoardRepository(this._appDb);

  Future<List<Board>> getAllBoard() {
    return _appDb.boardsDao.getAllBoards();
  }

  Future<List<BoardWithCategory>> getAllBoardWithCategory() {
    return _appDb.boardsDao.getAllBoardWithCategory();
  }

  Future<List<PanelData>> getAllPanels(int boardId) {
    return _appDb.panelDao.getAllPanels(boardId);
  }

  Future<int> create(Board board, String categoryName) async {
    int categoryId = await _appDb.categoryDao.insertCategory(categoryName);
    board = board.copyWith(category: categoryId);
    var result = await _appDb.boardsDao.insertBoard(board);
    return result;
  }

  Future<int> createPanel(PanelData panelData) async {
    var result = await _appDb.panelDao.insertPanel(panelData);
    return result;
  }
}
