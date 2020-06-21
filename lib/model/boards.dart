import 'package:moor/moor.dart';

class Boards extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min:1, max:255)();
  TextColumn get description => text().withLength(min:1)();
  DateTimeColumn get lastUpdated => dateTime().nullable()();
}