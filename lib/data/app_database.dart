import 'dart:io';
import 'package:laplanche/dao/boards_dao.dart';
import 'package:laplanche/dao/category_dao.dart';
import 'package:laplanche/dao/panel_dao.dart';
import 'package:laplanche/model/board_category.dart';
import 'package:laplanche/model/boards.dart';
import 'package:laplanche/model/panel.dart';
import 'package:laplanche/model/panel_item.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
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
        final dbFolder = await getApplicationDocumentsDirectory();
        final file = File(p.join(dbFolder.path, 'yotei.sqlite'));
        return VmDatabase(file);
      });
      return _lazyDatabase;
    }
    return _lazyDatabase;
  }
}
