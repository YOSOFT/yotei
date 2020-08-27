import 'package:equatable/equatable.dart';

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
  final panel;

  BoardEventCreatePanel(this.panel);
  @override
  List<Object> get props => [panel];

  @override
  bool get stringify => false;
}
