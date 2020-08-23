import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laplanche/bloc/by_category_bloc/by_category_event.dart';
import 'package:laplanche/bloc/by_category_bloc/by_category_state.dart';
import 'package:laplanche/model/board_with_category.dart';
import 'package:laplanche/repository/board_repository.dart';

class ByCategoryBloc extends Bloc<ByCategoryEvent, ByCategoryState> {
  final BoardRepository _boardRepository;

  ByCategoryBloc(this._boardRepository) : super(ByCategoryInitial());

  @override
  Stream<ByCategoryState> mapEventToState(ByCategoryEvent event) async* {
    if (event is GetAllByCategory) {
      yield* _getAllBoardWithCategory();
    }
  }

  Stream<ByCategoryState> _getAllBoardWithCategory() async* {
    try {
      yield ByCategoryLoading();
      final List<BoardWithCategory> _boards =
          await _boardRepository.getAllBoardWithCategory();
      yield AllBoardWithCategory(_boards);
    } catch (e) {
      print(e);
      yield ShowMessage("Something went wrong $e");
    }
  }
}
