import 'package:laplanche/components/penal_item.dart';

class PanelHeader {
  String title;
  List<PanelItem> panelItems = [];

  PanelHeader(this.title, this.panelItems);

  List<PanelItem> get getPanelItems {
    return panelItems;
  }

  set setPanelItems(List<PanelItem> items) {
    this.panelItems = items;
  }
}
