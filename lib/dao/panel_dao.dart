import 'package:laplanche/data/app_database.dart';
import 'package:laplanche/model/panel.dart';
import 'package:moor/moor.dart';

part 'panel_dao.g.dart';

@UseDao(tables: [Panel])
class PanelDao extends DatabaseAccessor<AppDatabase> with _$PanelDaoMixin {
  PanelDao(AppDatabase attachedDatabase) : super(attachedDatabase);

  Future<List<PanelData>> getAllPanels(int boardId) {
    return (select(panel)..where((tbl) => tbl.boardId.equals(boardId))).get();
  }

  Future deletePanel(PanelData panelData) => delete(panel).delete(panelData);
}
