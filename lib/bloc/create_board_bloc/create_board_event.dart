import 'package:equatable/equatable.dart';
import 'package:laplanche/data/app_database.dart';

abstract class CreateBoardEvent extends Equatable{}

class Save implements CreateBoardEvent {
  final Board board;

  const Save(this.board);

  @override
  List<Object> get props => [board];

  @override
  bool get stringify => true;

}