import 'package:equatable/equatable.dart';
import 'package:laplanche/model/board_with_category.dart';

abstract class SearchState extends Equatable {}

class SearchStateInitial implements SearchState {
  @override
  List<Object> get props => [];
  @override
  bool get stringify => false;
}

class SearchStateResult implements SearchState {
  final List<BoardWithCategory> boardWithCategories;

  SearchStateResult(this.boardWithCategories);

  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class SearchStateShowMessage implements SearchState {
  final String message;

  SearchStateShowMessage(this.message);

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => false;
}
