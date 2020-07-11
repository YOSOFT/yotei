import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laplanche/bloc/main_page_bloc/main_page_event.dart';
import 'package:laplanche/bloc/main_page_bloc/main_page_state.dart';
import 'package:laplanche/data/app_database.dart';
import 'package:laplanche/repository/board_repository.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState>{
  final BoardRepository _boardRepository;
  List<Board> boards = List(); 

  MainPageBloc(this._boardRepository) : super(MainPageInitial());

  @override
  Stream<MainPageState> mapEventToState(MainPageEvent event) async* {
    if(event is GetAll){
      yield* _getAllBoards();
    }
  }

  Stream<MainPageState> _getAllBoards() async* {
    try{
      List<Board> temp = await _boardRepository.getAllBoard();
      if(temp != null){
        boards.clear();
        boards.addAll(temp);
      }
      yield AllBoard(boards);
    }catch(e){
      print(e);
      yield ShowMessage("Something went wrong $e");
    }
  }

}