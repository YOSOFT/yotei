import 'package:laplanche/data/app_database.dart';
import 'package:laplanche/model/panel.dart';
import 'package:laplanche/model/panel_item.dart';
import 'package:laplanche/model/panel_with_items.dart';
import 'package:moor/moor.dart';

part 'panel_dao.g.dart';

@UseDao(tables: [Panel, PanelItem])
class PanelDao extends DatabaseAccessor<AppDatabase> with _$PanelDaoMixin {
  PanelDao(AppDatabase attachedDatabase) : super(attachedDatabase);

  Future<List<PanelData>> getAllPanels(int boardId) {
    return (select(panel)..where((tbl) => tbl.boardId.equals(boardId))).get();
  }

  Future<List<PanelItemData>> getAllPanelItems(int panelId) {
    return (select(panelItem)..where((tbl) => tbl.panelId.equals(panelId)))
        .get();
  }

  Future<List<PanelWithItems>> getAllPanelsWithItems(int boardId) async {
    List<PanelWithItems> panelWithItems = [];
    List<PanelData> panels = await (select(panel)
          ..where((tbl) => tbl.boardId.equals(boardId)))
        .get();

    for (var p in panels) {
      List<PanelItemData> items = await (select(panelItem)
            ..where((tbl) => tbl.panelId.equals(p.id)))
          .get();
      items.sort((a, b) => a.order.compareTo(b.order));
      panelWithItems.add(PanelWithItems(p, items));
    }
    return panelWithItems;
  }

  Future insertPanel(PanelData panelData) {
    var s = into(panel).insert(panelData);
    return s;
  }

  Future deletePanel(int panelId) {
    (delete(panel)..where((tbl) => tbl.id.equals(panelId))).go();
    return (delete(panelItem)..where((tbl) => tbl.panelId.equals(panelId)))
        .go();
  }

  Future deletePanelItem(int panelItemId) {
    return (delete(panelItem)..where((tbl) => tbl.id.equals(panelItemId))).go();
  }

  Future insertPanelItem(PanelItemData panelItemData) {
    var data = into(panelItem).insert(panelItemData);
    return data;
  }

  Future updatePanelPosition(PanelData pD) {
    var result = (update(panel)..where((t) => t.id.equals(pD.id))).write(
      PanelCompanion(
        order: Value(pD.order),
      ),
    );
    return result;
  }

  Future updatePanelValue(PanelData pd) {
    var result = (update(panel)..where((tbl) => tbl.id.equals(pd.id))).write(
        PanelCompanion(
            name: Value(pd.name), description: Value(pd.description)));
    return result;
  }

  Future updatePanelItemPosition(PanelItemData panelItemData) {
    var result =
        (update(panelItem)..where((t) => t.id.equals(panelItemData.id))).write(
      PanelItemCompanion(
        panelId: Value(panelItemData.panelId),
        order: Value(panelItemData.order),
      ),
    );
    return result;
  }
}
