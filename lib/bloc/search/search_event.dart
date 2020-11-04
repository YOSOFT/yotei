import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {}

class SearchEventDoSearch implements SearchEvent {
  final String query;
  SearchEventDoSearch(this.query);
  @override
  List<Object> get props => [query];

  @override
  bool get stringify => false;
}
