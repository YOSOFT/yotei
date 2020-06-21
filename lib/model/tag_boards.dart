import 'package:moor/moor.dart';

class TagBoards extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tagId => integer().customConstraint("REFERENCES tag(id) ON DELETE CASCADE")();
  IntColumn get boardId => integer().customConstraint("REFERENCES board(id) ON DELETE CASCADE")();
}