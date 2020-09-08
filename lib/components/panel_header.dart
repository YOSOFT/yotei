import 'package:flutter/material.dart';
import 'package:laplanche/components/penal_item_component.dart';

class PanelHeaderComponent {
  String title;
  List<PanelItemComponent> panelItems = [];

  PanelHeaderComponent(this.title, this.panelItems);
}
