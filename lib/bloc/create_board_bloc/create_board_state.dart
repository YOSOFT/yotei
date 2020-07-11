import 'package:equatable/equatable.dart';

abstract class CreateBoardState extends Equatable{}

class Initial implements CreateBoardState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;

}

class Loading implements CreateBoardState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;

}

class Success implements CreateBoardState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;

}

class ShowMessage implements CreateBoardState {
  final String message;

  const ShowMessage(this.message);  
  
  @override
  List<Object> get props => [message];

  @override
  bool get stringify => false;
}