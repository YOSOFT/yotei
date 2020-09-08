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
