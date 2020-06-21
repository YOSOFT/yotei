import 'dart:io';
import 'package:laplanche/dao/boards_dao.dart';
import 'package:laplanche/model/boards.dart';
import 'package:laplanche/model/tags.dart';
import 'package:laplanche/model/tag_boards.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';



@UseMoor(tables: [Boards, Tags, TagBoards], daos: [BoardsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  static LazyDatabase _lazyDatabase;

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    if(_lazyDatabase == null){
      _lazyDatabase = LazyDatabase(() async {
          final dbFolder = await getApplicationDocumentsDirectory();
          final file = File(p.join(dbFolder.path, 'yotei.sqlite'));
          return VmDatabase(file);
      });
      return _lazyDatabase;
    }
    return _lazyDatabase;
}

}

