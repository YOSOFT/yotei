import 'package:equatable/equatable.dart';
import 'package:laplanche/data/app_database.dart';

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
