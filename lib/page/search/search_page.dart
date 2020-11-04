import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:laplanche/bloc/search/search_bloc.dart';
import 'package:laplanche/bloc/search/search_event.dart';
import 'package:laplanche/bloc/search/search_state.dart';
import 'package:laplanche/data/app_database.dart';
import 'package:laplanche/model/board_with_category.dart';
import 'package:laplanche/page/board/my_board_page.dart';
import 'package:laplanche/repository/board_repository.dart';
import 'package:laplanche/utils/injector.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchBar _searchBar;
  SearchBloc _searchBloc;
  String query = "";
  List<BoardWithCategory> _boards = List();

  _SearchPageState() {
    _searchBar = SearchBar(
        inBar: false,
        setState: setState,
        buildDefaultAppBar: buildAppBar,
        onChanged: (callback) {
          query = callback.toString().trim();
          if (query != "") {
            _doSearch(query);
          }else{
            _boards.clear();
          }
        });
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: Text('Search'), actions: [_searchBar.getSearchAction(context)]);
  }

  @override
  void initState() {
    _searchBloc = SearchBloc(BoardRepository(locator<AppDatabase>()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _searchBar.build(context),
      body: BlocConsumer(
          cubit: _searchBloc,
          builder: (context, state) => _buildList(),
          listener: (context, state) {
                if (state is SearchStateShowMessage){
                  print(state.message);
                }else if (state is SearchStateResult){
                  print("supses ${state.boardWithCategories.length}");
                  _boards.clear();
                  _boards.addAll(state.boardWithCategories);
                }
              }),
    );
  }

  _doSearch(q) {
    _searchBloc.add(SearchEventDoSearch(q));
  }

  _buildList() {
    return ListView.builder(
        physics: ClampingScrollPhysics(),
        itemCount: _boards.length,
        itemBuilder: (context, index) {
          BoardWithCategory board = _boards[index];
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                InkWell(
                  onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MyBoardPage(boardWithCategory: _boards[index]);
                    })).then((value) => _doSearch(query))
                  },
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
        });
  }
}
