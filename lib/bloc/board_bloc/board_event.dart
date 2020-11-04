import 'package:equatable/equatable.dart';
import 'package:laplanche/data/app_database.dart';
import 'package:laplanche/model/board_with_category.dart';

abstract class BoardEvent extends Equatable {}

class BoardEventGetAllPanels implements BoardEvent {
  final boardId;
  BoardEventGetAllPanels(this.boardId);

  @override
  List<Object> get props => [boardId];

  @override
  bool get stringify => false;
}

class BoardEventCreatePanel implements BoardEvent {
  final PanelData panelData;

  BoardEventCreatePanel(this.panelData);
  @override
  List<Object> get props => [panelData];

  @override
  bool get stringify => false;
}

class BoardEventCreatePanelItem implements BoardEvent {
  final int panelId;
  final PanelItemData panelItemData;

  BoardEventCreatePanelItem(this.panelId, this.panelItemData);

  @override
  List<Object> get props => [panelId, panelItemData];

  @override
  bool get stringify => false;
}

class BoardEventGetPanelWithItems implements BoardEvent {
  final int boardId;

  BoardEventGetPanelWithItems(this.boardId);

  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class BoardEventSavePanelPosition implements BoardEvent {
  final List<PanelData> panelDatas;
  final int boardId;

  BoardEventSavePanelPosition(this.panelDatas, this.boardId);

  @override
  List<Object> get props => [panelDatas, boardId];

  @override
  bool get stringify => false;
}

class BoardEventDeletePanel implements BoardEvent {
  final int panelId;
  final List<PanelData> panelDatas;

  BoardEventDeletePanel(this.panelId, this.panelDatas);

  @override
  List<Object> get props => [panelId, panelDatas];

  @override
  bool get stringify => false;
}

class BoardEventDeletePanelItem implements BoardEvent {
  final int boardId;
  final int panelItemId;
  final List<PanelItemData> panelItemsToOrder;

  BoardEventDeletePanelItem(
      this.boardId, this.panelItemId, this.panelItemsToOrder);

  @override
  List<Object> get props => [boardId, panelItemId, panelItemsToOrder];

  @override
  bool get stringify => false;
}

class BoardEventUpdatePanelItemPosition implements BoardEvent {
  final List<PanelItemData> panelItemDatas;
  final int panelId;
  final int boardId;

  BoardEventUpdatePanelItemPosition(
      this.panelItemDatas, this.panelId, this.boardId);

  @override
  List<Object> get props => [panelItemDatas, panelId, boardId];

  @override
  bool get stringify => false;
}

class BoardEventUpdatePanelItemPositionAlt implements BoardEvent {
  final List<PanelItemData> oldItemDatas;
  final List<PanelItemData> insertedItemDatas;
  final int boardId;

  BoardEventUpdatePanelItemPositionAlt(
      this.oldItemDatas, this.insertedItemDatas, this.boardId);

  @override
  List<Object> get props => [oldItemDatas, insertedItemDatas, boardId];

  @override
  bool get stringify => false;
}

class BoardEventUpdatePanelValue implements BoardEvent {
  final PanelData panelData;

  BoardEventUpdatePanelValue(this.panelData);

  @override
  List<Object> get props => [panelData];

  @override
  bool get stringify => false;
}

class BoardEventUpdatePanelItemValue implements BoardEvent {
  final PanelItemData panelItemData;
  final int boardId;

  BoardEventUpdatePanelItemValue(this.panelItemData, this.boardId);

  @override
  List<Object> get props => [panelItemData, boardId];

  @override
  bool get stringify => false;
}

class BoardEventGetSingleBoardWithCategory implements BoardEvent {
  final BoardWithCategory boardWithCategory;

  BoardEventGetSingleBoardWithCategory(this.boardWithCategory);

  @override
  List<Object> get props => [boardWithCategory];

  @override
  bool get stringify => false;
}

class BoardEventUpdateBoardValue implements BoardEvent {
  final BoardWithCategory bwc;

  BoardEventUpdateBoardValue(this.bwc);
  @override
  List<Object> get props => [bwc];

  @override
  bool get stringify => false;
}

class BoardEventDeleteBoard implements BoardEvent {
  final BoardWithCategory bwc;

  BoardEventDeleteBoard(this.bwc);

  @override
  List<Object> get props => [bwc];

  @override
  bool get stringify => false;
}
