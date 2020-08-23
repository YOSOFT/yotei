import 'package:equatable/equatable.dart';
import 'package:laplanche/model/board_with_category.dart';

abstract class ByCategoryState extends Equatable {}

class ByCategoryInitial implements ByCategoryState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class ByCategoryLoading implements ByCategoryState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class AllBoardWithCategory implements ByCategoryState {
  final List<BoardWithCategory> boards;

  AllBoardWithCategory(this.boards);

  @override
  List<Object> get props => [boards];

  @override
  bool get stringify => false;
}

class ShowMessage implements ByCategoryState {
  final String message;

  ShowMessage(this.message);

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => false;
}
