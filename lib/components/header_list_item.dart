import 'package:flutter/material.dart';
import 'package:laplanche/utils/board_section.dart';

class HeaderListItem extends StatelessWidget {
  final List<BoardSection> sectionList;
  final int sectionIndex;

  HeaderListItem(this.sectionList, this.sectionIndex);

  @override
  Widget build(BuildContext context) {
    BoardSection section = sectionList[sectionIndex];
    return InkWell(
        child: Container(
            color: Theme.of(context).colorScheme.background,
            height: 48,
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              section.title,
              style: TextStyle(color: Colors.white),
            )),
        onTap: () {
          print("hehe");
          //toggle section expand state
          // setState(() {
          //   section.setSectionExpanded(!section.isSectionExpanded());
          // });
        });
  }
}
