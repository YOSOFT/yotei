import 'package:laplanche/data/app_database.dart';
import 'package:laplanche/repository/board_repository.dart';
import 'package:laplanche/store/create_board_page/create_board_state.dart';
import 'package:mobx/mobx.dart';

part 'create_board_store.g.dart';

class CreateBoardStore extends _CreateBoardStore with _$CreateBoardStore {
  CreateBoardStore(BoardRepository boardRepository) : super(boardRepository);
}

abstract class _CreateBoardStore with Store {
  BoardRepository _boardRepository;

  _CreateBoardStore(BoardRepository boardRepository){
    this._boardRepository = boardRepository;
    state = CreateBoardState.initial();

  }

  @observable
  CreateBoardState state;

  void _isLoading(bool b) => state = CreateBoardState.loading(b);
  void _success() => state = CreateBoardState.success();
  void _showMessage(String message) => CreateBoardState.showMessage(message);


  @action
  void createBoard(Board board){
    _isLoading(true);
    _boardRepository.create(board).then((value) {
      _isLoading(false);
      _success();
    }).catchError((onError) {
      print(onError);
      _isLoading(false);
      _showMessage("Something went wrong");
    });
  }


}