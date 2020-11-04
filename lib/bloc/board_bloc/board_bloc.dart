import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laplanche/bloc/board_bloc/board_event.dart';
import 'package:laplanche/bloc/board_bloc/board_state.dart';
import 'package:laplanche/data/app_database.dart';
import 'package:laplanche/model/board_with_category.dart';
import 'package:laplanche/repository/board_repository.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  final BoardRepository _boardRepository;
  BoardBloc(this._boardRepository) : super(BoardStateInitial());

  @override
  Stream<BoardState> mapEventToState(BoardEvent event) async* {
    if (event is BoardEventGetAllPanels) {
      yield* _getAllPanels(event.boardId);
    } else if (event is BoardEventCreatePanel) {
      yield* _createPanel(event.panelData);
    } else if (event is BoardEventCreatePanelItem) {
      yield* _createPanelItem(event.panelId, event.panelItemData);
    } else if (event is BoardEventGetPanelWithItems) {
      yield* _getPanelWithItems(event.boardId);
    } else if (event is BoardEventSavePanelPosition) {
      yield* _savePanelPositionToDatabase(event.panelDatas, event.boardId);
    } else if (event is BoardEventDeletePanel) {
      yield* _deletePanel(event.panelId, event.panelDatas);
    }
    // else if (event is BoardEventUpdatePanelItemPosition) {
    //   yield* _saveItemPositionToDatabase(
    //       event.panelItemDatas, event.panelId, event.boardId);
    // }
    else if (event is BoardEventUpdatePanelItemPositionAlt) {
      yield* _saveItemPositionToDatabaseAlt(
          event.oldItemDatas, event.insertedItemDatas, event.boardId);
    } else if (event is BoardEventDeletePanelItem) {
      yield* _deletePanelItem(
          event.boardId, event.panelItemId, event.panelItemsToOrder);
    } else if (event is BoardEventUpdatePanelValue) {
      yield* _updatePanelValue(event.panelData);
    } else if (event is BoardEventUpdatePanelItemValue) {
      yield* _updatePanelItemValue(event.panelItemData, event.boardId);
    } else if (event is BoardEventGetSingleBoardWithCategory) {
      yield* _getSingleBoardWithCategory(event.boardWithCategory);
    } else if (event is BoardEventUpdateBoardValue) {
      yield* _updateBoardValue(event.bwc);
    } else if (event is BoardEventDeleteBoard) {
      yield* _deleteBoard(event.bwc);
    }
  }

  Stream<BoardState> _getAllPanels(int boardId) async* {
    try {
      var panels = await _boardRepository.getAllPanels(boardId);
      yield BoardStatePanelsLoaded(panels);
    } catch (e) {
      print("Something went wrong $e");
      yield BoardStateShowToast("There is something wrong..");
    }
  }

  Stream<BoardState> _createPanel(PanelData panelData) async* {
    try {
      yield BoardStateLoading();
      var currentPanels =
          await _boardRepository.getAllPanelWithItems(panelData.boardId);
      int lastIndex = currentPanels.isEmpty
          ? 0
          : currentPanels[currentPanels.length - 1].panelData.order + 1;
      panelData = panelData.copyWith(order: lastIndex);
      await _boardRepository.createPanel(panelData);
      yield BoardStateRefresh();
      yield BoardStateShowToast("Sukses insert");
    } catch (e) {
      print("Something went wrong $e");
      yield BoardStateShowToast("There is something wrong..");
    }
  }

  Stream<BoardState> _getPanelWithItems(int boardId) async* {
    try {
      var panels = await _boardRepository.getAllPanelWithItems(boardId);
      yield BoardStatePanelWithItems(panels);
    } catch (e) {
      print("Something went wrong $e");
      yield BoardStateShowToast("There is something wrong..");
    }
  }

  Stream<BoardState> _createPanelItem(
      int panelId, PanelItemData panelItemData) async* {
    try {
      yield BoardStateLoading();
      List<PanelItemData> currentPanelItems =
          await _boardRepository.getAllPanelItems(panelId);
      int order = currentPanelItems.isEmpty
          ? 0
          : currentPanelItems[currentPanelItems.length - 1].order + 1;
      PanelItemData updatedPanelItem = panelItemData.copyWith(order: order);
      await _boardRepository.createPanelItem(updatedPanelItem);
      yield BoardStateRefresh();
      yield BoardStateShowToast("Item created");
    } catch (e) {
      print("Exception on createPanelItem $e");
      yield BoardStateShowToast("Error occured...");
    }
  }

  Stream<BoardState> _savePanelPositionToDatabase(
      List<PanelData> panelDatas, int boardId) async* {
    try {
      yield BoardStateLoading();
      await _boardRepository.updatePanelPosition(panelDatas);
      var panels = await _boardRepository.getAllPanelWithItems(boardId);
      yield BoardStatePanelWithItems(panels);
    } catch (e) {
      print("Exception on save panel position $e");
      yield BoardStateShowToast("Error occured...");
    }
  }

  // Stream<BoardState> _saveItemPositionToDatabase(
  //     List<PanelItemData> panelItemDatas, int panelId, int boardId) async* {
  //   try {
  //     yield BoardStateLoading();
  //     await _boardRepository.updatePanelItemPosition(panelItemDatas);
  //     var panels = await _boardRepository.getAllPanelWithItems(boardId);
  //     yield BoardStatePanelWithItems(panels);
  //   } catch (e) {
  //     print("Exception on save panel item data position %e");
  //     yield BoardStateShowToast("Error occured...");
  //   }
  // }

  Stream<BoardState> _saveItemPositionToDatabaseAlt(
      List<PanelItemData> oldItemDatas,
      List<PanelItemData> insertedItems,
      int boardId) async* {
    try {
      yield BoardStateLoading();
      await _boardRepository.updatePanelItemPosition(oldItemDatas);
      await _boardRepository.updatePanelItemPosition(insertedItems);
      var panels = await _boardRepository.getAllPanelWithItems(boardId);
      yield BoardStatePanelWithItems(panels);
    } catch (e) {
      print("Exception on save panel item data position %e");
      yield BoardStateShowToast("Error occured...");
    }
  }

  Stream<BoardState> _deletePanel(
      int panelId, List<PanelData> panelDatas) async* {
    try {
      yield BoardStateLoading();
      int boardId = panelDatas[0].boardId;
      await _boardRepository.deletePanel(panelId);
      await _boardRepository.updatePanelPosition(panelDatas);
      var panels = await _boardRepository.getAllPanelWithItems(boardId);
      yield BoardStatePanelWithItems(panels);
    } catch (e) {
      print("Exception on delete panel $e");
      yield BoardStateShowToast("Error occured...");
    }
  }

  Stream<BoardState> _deletePanelItem(
      int boardId, int panelItemId, List<PanelItemData> panelItemDatas) async* {
    try {
      yield BoardStateLoading();
      await _boardRepository.deletePanelItem(panelItemId);
      await _boardRepository.updatePanelItemPosition(panelItemDatas);
      var panels = await _boardRepository.getAllPanelWithItems(boardId);
      yield BoardStatePanelWithItems(panels);
    } catch (e) {
      print("Exception in deletePanelItem $e");
      yield BoardStateShowToast("Error occured");
    }
  }

  Stream<BoardState> _updatePanelValue(PanelData panelData) async* {
    try {
      yield BoardStateLoading();
      await _boardRepository.updatePanelValue(panelData);
      var panels =
          await _boardRepository.getAllPanelWithItems(panelData.boardId);
      yield BoardStatePanelWithItems(panels);
    } catch (e) {
      print("Exceptionn in updatePanelValue $e");
      yield BoardStateShowToast("Error occured");
    }
  }

  Stream<BoardState> _updatePanelItemValue(
      PanelItemData panelItemData, int boardId) async* {
    try {
      yield BoardStateLoading();
      await _boardRepository.updatePanelItemValue(panelItemData);
      var panels = await _boardRepository.getAllPanelWithItems(boardId);
      yield BoardStatePanelWithItems(panels);
    } catch (e) {
      print("Exception in updatePanelItemValue $e");
      yield BoardStateShowToast("Error occured");
    }
  }

  Stream<BoardState> _getSingleBoardWithCategory(
      BoardWithCategory boardWithCategory) async* {
    try {
      print(boardWithCategory);
      yield BoardStateLoading();
      var bwc = await _boardRepository
          .getSingleBoardWithCategory(boardWithCategory.board);
      yield BoardStateSingleBoardWithCategory(bwc);
    } catch (e) {
      print("Exception in _getSingleBoardWithCat $e");
      yield BoardStateShowToast("Error occured");
    }
  }

  Stream<BoardState> _updateBoardValue(BoardWithCategory bwc) async* {
    try {
      print("Board bloc");
      yield BoardStateLoading();
      int categoryId = await _boardRepository.updateBoardValue(bwc);
      if (categoryId != -1) {
        var updated = await _boardRepository.getSingleBoardWithCategory(
            bwc.board.copyWith(category: categoryId));
        yield BoardStateSingleBoardWithCategory(updated);
      }
    } catch (e) {
      print("Exception in updateBoardvalue $e");
      yield BoardStateShowToast("Error occured");
    }
  }

  Stream<BoardState> _deleteBoard(BoardWithCategory bwc) async* {
    try {
      yield BoardStateLoading();
      await _boardRepository.destroyBoard(bwc);
      yield BoardStateFinishPage();
    } catch (e) {
      print("Exception on deleteBoard $e");
      yield BoardStateShowToast("Error occured");
    }
  }
}
