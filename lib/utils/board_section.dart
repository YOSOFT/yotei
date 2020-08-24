import 'package:laplanche/model/board_with_category.dart';
import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';

class BoardSection implements ExpandableListSection<BoardWithCategory> {
  bool isExpanded;
  List<BoardWithCategory> boardWithCategory = List();
  String title;

  @override
  bool isSectionExpanded() => isExpanded;

  @override
  void setSectionExpanded(bool expanded) {
    this.isExpanded = expanded;
  }

  @override
  List<BoardWithCategory> getItems() {
    return boardWithCategory;
  }
}
