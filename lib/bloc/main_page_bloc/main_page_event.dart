import 'package:equatable/equatable.dart';

abstract class MainPageEvent extends Equatable {}

class GetAll implements MainPageEvent {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class GetAllByCategory implements MainPageEvent {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}
