import 'package:equatable/equatable.dart';
import 'package:laplanche/data/app_database.dart';
import 'package:laplanche/model/panel_with_items.dart';

abstract class BoardState extends Equatable {}

class BoardStateInitial implements BoardState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class BoardStateLoading implements BoardState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class BoardStatePanelsLoaded implements BoardState {
  final List<PanelData> panels;

  BoardStatePanelsLoaded(this.panels);
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class BoardStateShowToast implements BoardState {
  final String message;

  BoardStateShowToast(this.message);

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => false;
}

class BoardStateRefresh implements BoardState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class BoardStatePanelWithItems implements BoardState {
  final List<PanelWithItems> panelWithItems;

  BoardStatePanelWithItems(this.panelWithItems);

  @override
  List<Object> get props => [panelWithItems];

  @override
  bool get stringify => false;
}
