import 'package:equatable/equatable.dart';
import 'package:laplanche/data/app_database.dart';

abstract class CreateBoardEvent extends Equatable {}

class Save implements CreateBoardEvent {
  final Board board;
  final String categoryName;

  const Save(this.board, this.categoryName);

  @override
  List<Object> get props => [board, categoryName];

  @override
  bool get stringify => true;
}
