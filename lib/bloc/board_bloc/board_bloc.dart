import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laplanche/bloc/board_bloc/board_event.dart';
import 'package:laplanche/bloc/board_bloc/board_state.dart';
import 'package:laplanche/model/panel.dart';
import 'package:laplanche/repository/board_repository.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  final BoardRepository _boardRepository;
  BoardBloc(this._boardRepository) : super(BoardStateInitial());

  @override
  Stream<BoardState> mapEventToState(BoardEvent event) async* {
    if (event is BoardEventGetAllPanels) {
      yield* _getAllPanels(event.boardId);
    } else if (event is BoardEventCreatePanel) {
      yield* _createPanel(event.panel);
    }
  }

  Stream<BoardState> _getAllPanels(int boardId) async* {
    try {
      var panels = await _boardRepository.getAllPanels(boardId);
      yield BoardStatePanelsLoaded(panels);
    } catch (e) {
      print("Something went wrong $e");
      yield BoardStateShowToast("There is something wrong..");
    }
  }

  Stream<BoardState> _createPanel(Panel panel) async* {
    try {} catch (e) {
      print("Something went wrong $e");
      yield BoardStateShowToast("There is something wrong..");
    }
  }
}
