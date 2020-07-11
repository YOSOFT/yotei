import 'package:equatable/equatable.dart';
import 'package:laplanche/data/app_database.dart';

abstract class MainPageState extends Equatable{}

class MainPageInitial implements MainPageState{
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;

}
class MainPageLoading implements MainPageState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;

}

class AllBoard implements MainPageState{
  final List<Board> allBoard;

  AllBoard(this.allBoard);
  
  @override
  List<Object> get props => [allBoard];

  @override
  bool get stringify => true;

}

class ShowMessage implements MainPageState{
  final String message;
  
  ShowMessage(this.message);

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => false;

}