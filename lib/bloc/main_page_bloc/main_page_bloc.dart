import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laplanche/bloc/main_page_bloc/main_page_event.dart';
import 'package:laplanche/bloc/main_page_bloc/main_page_state.dart';
import 'package:laplanche/model/board_with_category.dart';
import 'package:laplanche/repository/board_repository.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final BoardRepository _boardRepository;

  MainPageBloc(this._boardRepository) : super(MainPageInitial());

  @override
  Stream<MainPageState> mapEventToState(MainPageEvent event) async* {
    if (event is GetAll) {
      yield* _getAllBoards();
    } else if (event is GetAllByCategory) {
      yield* _getCategorizedBoards();
    }
  }

  Stream<MainPageState> _getAllBoards() async* {
    try {
      yield MainPageLoading();
      List<BoardWithCategory> temp =
          await _boardRepository.getAllBoardWithCategory();
      yield AllBoardWithCategory(temp);
    } catch (e) {
      print(e);
      yield ShowMessage("Something went wrong $e");
    }
  }

  Stream<MainPageState> _getCategorizedBoards() async* {
    try {
      yield MainPageLoading();
      final List<BoardWithCategory> _boards =
          await _boardRepository.getAllBoardWithCategory();
      var _filtered = _boards.fold<Map<String, List<BoardWithCategory>>>({},
          (boardWithCategoryMap, currentBoardWithCategory) {
        if (boardWithCategoryMap[
                currentBoardWithCategory.boardCategoryData.name] ==
            null) {
          boardWithCategoryMap[currentBoardWithCategory
              .boardCategoryData.name] = <BoardWithCategory>[];
        }
        boardWithCategoryMap[currentBoardWithCategory.boardCategoryData.name]
            .add(currentBoardWithCategory);
        return boardWithCategoryMap;
      });
      yield GetCategorizedBoards(_filtered);
    } catch (e) {
      print("Exception $e");
      yield ShowMessage("Something went wrong $e");
    }
  }
}
