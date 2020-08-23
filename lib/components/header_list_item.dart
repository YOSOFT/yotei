import 'package:flutter/material.dart';
import 'package:laplanche/page/home/mock_data.dart';

class HeaderListItem extends StatelessWidget {
  final List<ExampleSection> sectionList;
  final int sectionIndex;

  HeaderListItem(this.sectionList, this.sectionIndex);

  @override
  Widget build(BuildContext context) {
    ExampleSection section = sectionList[sectionIndex];
    return InkWell(
        child: Container(
            color: Colors.lightBlue,
            height: 48,
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              section.header,
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
