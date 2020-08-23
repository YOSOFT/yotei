import 'package:flutter/material.dart';
import 'package:laplanche/bloc/by_category_bloc/by_category_bloc.dart';
import 'package:laplanche/components/header_list_item.dart';
import 'package:laplanche/page/home/mock_data.dart';
import 'package:laplanche/repository/board_repository.dart';
import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';

class CategorizedComponent extends StatefulWidget {
  @override
  _CategorizedComponentState createState() => _CategorizedComponentState();
}

class _CategorizedComponentState extends State<CategorizedComponent>
    with AutomaticKeepAliveClientMixin<CategorizedComponent> {
  var sectionList = MockData.getExampleSections();
  var _controller = ExpandableListController();
  // List<BoardWithCategory> _boardWithCategory = List();
  ByCategoryBloc _byCategoryBloc;

  @override
  void initState() {
    super.initState();
    _byCategoryBloc = ByCategoryBloc(BoardRepository());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
              child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
              child: Text("categorized",
                  style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Assistant")),
            ),
          )),
          SliverExpandableList(
            builder: SliverExpandableChildDelegate<String, ExampleSection>(
                sectionList: sectionList,
                headerBuilder: _buildHeaderList,
                controller: _controller,
                itemBuilder: (context, sectionIndex, itemIndex, index) {
                  String item = sectionList[sectionIndex].items[itemIndex];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text("$index"),
                    ),
                    title: Text(item),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget _buildHeaderList(BuildContext context, int sectionIndex, int index) {
    return HeaderListItem(sectionList, sectionIndex);
  }

  @override
  bool get wantKeepAlive => true;
}
