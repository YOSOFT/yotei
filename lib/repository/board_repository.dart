import 'package:laplanche/data/app_database.dart';
import 'package:laplanche/model/board_with_category.dart';
import 'package:laplanche/model/panel_with_items.dart';

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

  Future<List<PanelItemData>> getAllPanelItems(int panelId) {
    return _appDb.panelDao.getAllPanelItems(panelId);
  }

  Future<List<PanelWithItems>> getAllPanelWithItems(int boardId) async {
    List<PanelWithItems> panelWithCategories =
        await _appDb.panelDao.getAllPanelsWithItems(boardId);
    panelWithCategories
        .sort((a, b) => a.panelData.order.compareTo(b.panelData.order));
    return panelWithCategories;
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

  Future<int> createPanelItem(PanelItemData panelItemData) async {
    var result = await _appDb.panelDao.insertPanelItem(panelItemData);
    return result;
  }

  Future<bool> updatePanelPosition(List<PanelData> panelDatas) async {
    for (int i = 0; i < panelDatas.length; i++) {
      panelDatas[i] = panelDatas[i].copyWith(order: i);
      await _appDb.panelDao.updatePanelPosition(panelDatas[i]);
    }
    return true;
  }

  Future<bool> updatePanelItemPosition(
      List<PanelItemData> panelItemDatas) async {
    try {
      for (int i = 0; i < panelItemDatas.length; i++) {
        panelItemDatas[i] = panelItemDatas[i].copyWith(order: i);
        await _appDb.panelDao.updatePanelItemPosition(panelItemDatas[i]);
      }
      return true;
    } catch (e) {
      print("Exception in repo update panel item position $e");
      return false;
    }
  }

  Future<int> deletePanel(int panelId) async {
    var result = await _appDb.panelDao.deletePanel(panelId);
    return result;
  }

  Future<int> deletePanelItem(int panelItemId) async {
    var result = await _appDb.panelDao.deletePanelItem(panelItemId);
    return result;
  }

  Future<int> deleteCategoryIfNotUsed(int categoryId) async {
    List<Board> boardsWithCurrentCategory =
        await _appDb.boardsDao.getAllBoardByCategoryId(categoryId);
    if (boardsWithCurrentCategory.isEmpty) {
      return await _appDb.categoryDao.deleteCategoryById(categoryId);
    }
    return 1;
  }
}
