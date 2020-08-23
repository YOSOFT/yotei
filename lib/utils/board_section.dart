import 'package:laplanche/model/board_with_category.dart';
import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';

class BoardSection implements ExpandableListSection {
  bool isExpanded;
  List<BoardWithCategory> boardWithCategory;
  String title;

  @override
  List<BoardWithCategory> getItems() => boardWithCategory;

  @override
  bool isSectionExpanded() => isExpanded;

  @override
  void setSectionExpanded(bool expanded) {
    this.isExpanded = expanded;
  }
}
