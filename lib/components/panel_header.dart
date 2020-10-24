import 'package:laplanche/components/penal_item.dart';
import 'package:laplanche/data/app_database.dart';

class PanelHeader {
  PanelData panelData;
  String title;
  List<PanelItem> panelItems = [];
  List<PanelItemData> panelItemDatas = [];

  PanelHeader(this.panelData, this.title, this.panelItems, this.panelItemDatas);

  List<PanelItem> get getPanelItems {
    return panelItems;
  }

  List<PanelItemData> get panelItemsAlt {
    return panelItemDatas;
  }

  set setPanelItems(List<PanelItem> items) {
    this.panelItems = items;
  }
}
