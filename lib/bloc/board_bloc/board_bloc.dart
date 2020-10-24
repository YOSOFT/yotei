import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laplanche/bloc/board_bloc/board_event.dart';
import 'package:laplanche/bloc/board_bloc/board_state.dart';
import 'package:laplanche/data/app_database.dart';
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
          await _boardRepository.getAllPanels(panelData.boardId);
      currentPanels.forEach((element) {
        print(element);
      });
      int lastIndex = currentPanels.isEmpty
          ? 1
          : currentPanels[currentPanels.length - 1].order + 1;
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
      print("atta halilintar");
      print(panels);
      panels.forEach((element) {
        print(element.panelData.name);
        print(element.panelItemDatas.length);
      });
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
          ? 1
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
}
