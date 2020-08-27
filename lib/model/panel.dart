import 'package:moor/moor.dart';

class Panel extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 255)();
  TextColumn get description => text().withLength(min: 1)();
  IntColumn get boardId => integer()();
  IntColumn get order => integer()();
  DateTimeColumn get lastUpdated => dateTime().nullable()();
}
