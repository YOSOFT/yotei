import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laplanche/bloc/main_page_bloc/main_page_bloc.dart';
import 'package:laplanche/bloc/main_page_bloc/main_page_event.dart';
import 'package:laplanche/bloc/main_page_bloc/main_page_state.dart';
import 'package:laplanche/components/header_list_item.dart';
import 'package:laplanche/model/board_with_category.dart';
import 'package:laplanche/page/board/my_board_page.dart';
import 'package:laplanche/utils/board_section.dart';
import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';
import 'package:toast/toast.dart';

class CategorizedComponent extends StatefulWidget {
  @override
  _CategorizedComponentState createState() => _CategorizedComponentState();
}

class _CategorizedComponentState extends State<CategorizedComponent>
    with AutomaticKeepAliveClientMixin<CategorizedComponent> {
  List<BoardSection> _sectionList = List();
  var _controller = ExpandableListController();
  Map<String, List<BoardWithCategory>> _boardWithCategory = Map();
  MainPageBloc _mainPageBloc;

  @override
  void initState() {
    _mainPageBloc = BlocProvider.of<MainPageBloc>(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _fetchBoard();
    super.didChangeDependencies();
  }

  void _fetchBoard() {
    _mainPageBloc.add(GetAllByCategory());
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
      child: BlocConsumer<MainPageBloc, MainPageState>(
        cubit: _mainPageBloc,
        listener: (context, state) {
          if (state is ShowMessage) {
            _showMessage(state.message);
          } else if (state is GetCategorizedBoards) {
            _boardWithCategory = state.boards;
            _processDataToSection();
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                  child: Container(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                  child: Text("categorized",
                      style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Assistant")),
                ),
              )),
              SliverExpandableList(
                builder: SliverExpandableChildDelegate<BoardWithCategory,
                        BoardSection>(
                    sectionList: _sectionList,
                    headerBuilder: _buildHeaderList,
                    controller: _controller,
                    itemBuilder: (context, sectionIndex, itemIndex, index) {
                      BoardWithCategory board = _sectionList[sectionIndex]
                          .boardWithCategory[itemIndex];
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            InkWell(
                              onTap: () => Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return MyBoardPage(boardWithCategory: board);
                              })),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "${board.board.name}",
                                      style: TextStyle(
                                          fontFamily: "Assistant",
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${board.board.description}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: TextStyle(
                                        fontFamily: "Assistant",
                                      ),
                                    ),
                                    Text(
                                      "${board.boardCategoryData.name}",
                                      style: TextStyle(fontFamily: "Assistant"),
                                    ),
                                    Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text("Date")),
                                  ],
                                ),
                              ),
                            ),
                            Divider()
                          ],
                        ),
                      );
                    }),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeaderList(BuildContext context, int sectionIndex, int index) {
    return HeaderListItem(_sectionList, sectionIndex);
  }

  _processDataToSection() {
    _sectionList.clear();
    _boardWithCategory.forEach((key, value) {
      _sectionList.add(BoardSection()
        ..isExpanded = true
        ..title = key
        ..boardWithCategory = value);
    });
  }

  @override
  bool get wantKeepAlive => true;

  void _showMessage(message) => Toast.show(message, context);
}
