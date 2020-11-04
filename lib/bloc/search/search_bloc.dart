import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laplanche/bloc/search/search_event.dart';
import 'package:laplanche/bloc/search/search_state.dart';
import 'package:laplanche/repository/board_repository.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final BoardRepository _boardRepository;

  SearchBloc(this._boardRepository) : super(SearchStateInitial());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchEventDoSearch) {
      yield* _doSearch(event.query);
    }
  }

  Stream<SearchState> _doSearch(String query) async* {
    try {
      var boards = await _boardRepository.searchBoards(query);
      print(boards.length.toString());
      boards.forEach((element) {
        print(element.board.name);
       });
      yield SearchStateResult(boards);
    } catch (e) {
      print("Exception in doSearch() $e");
      yield SearchStateShowMessage("Exception occured...");
    }
  }
}
