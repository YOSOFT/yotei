import 'package:equatable/equatable.dart';

abstract class ByCategoryEvent extends Equatable {}

class GetAllByCategory implements ByCategoryEvent {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}
