import 'package:moor/moor.dart';

class BoardCategory extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 255)();
}
