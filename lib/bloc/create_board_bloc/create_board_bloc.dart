import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laplanche/bloc/create_board_bloc/create_board_event.dart';
import 'package:laplanche/bloc/create_board_bloc/create_board_state.dart';
import 'package:laplanche/data/app_database.dart';
import 'package:laplanche/repository/board_repository.dart';

class CreateBoardBloc extends Bloc<CreateBoardEvent, CreateBoardState> {
  final BoardRepository _boardRepository;

  CreateBoardBloc(this._boardRepository) : super(Initial());

  @override
  Stream<CreateBoardState> mapEventToState(CreateBoardEvent event) async* {
    if (event is Save) {
      yield* _saveBoard(event.board, event.categoryName);
    }
  }

  Stream<CreateBoardState> _saveBoard(Board board, String categoryName) async* {
    try {
      yield Loading();
      int data = await _boardRepository.create(board, categoryName);
      print(data);
      if (data != null && data != 0) {
        yield Success();
      } else {
        yield ShowMessage("Cannot save your board");
      }
    } catch (e) {
      print(e);
      yield ShowMessage("Something went wrong: $e");
    }
  }
}
