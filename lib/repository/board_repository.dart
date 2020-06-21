import 'package:laplanche/data/app_database.dart';

class BoardRepository {
  final boardDao = AppDatabase().boardsDao;

  Future<List<Board>> getAllBoard(){
    return boardDao.getAllBoards();
  }

  Future<int> create(Board board) async {
    var result = await boardDao.insertBoard(board);
    return result;
  }

}