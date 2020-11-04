import 'dart:io';
import 'package:laplanche/dao/boards_dao.dart';
import 'package:laplanche/dao/category_dao.dart';
import 'package:laplanche/dao/panel_dao.dart';
import 'package:laplanche/model/board_category.dart';
import 'package:laplanche/model/boards.dart';
import 'package:laplanche/model/panel.dart';
import 'package:laplanche/model/panel_item.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/database.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart' as paths;
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

@UseMoor(
    tables: [Boards, BoardCategory, Panel, PanelItem],
    daos: [BoardsDao, CategoryDao, PanelDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  static LazyDatabase _lazyDatabase;

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    if (_lazyDatabase == null) {
      _lazyDatabase = LazyDatabase(() async {
        File file;
        if (Platform.isMacOS || Platform.isLinux) {
          file = File('db.sqlite');
        }else{
          final dbFolder = await paths.getApplicationDocumentsDirectory();
          file = File(p.join(dbFolder.path, 'yotei.sqlite'));
        }
        return VmDatabase(file);
      });
      return _lazyDatabase;
    }
    return _lazyDatabase;
  }
}
