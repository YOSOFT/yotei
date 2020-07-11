import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laplanche/bloc/main_page_bloc/main_page_bloc.dart';
import 'package:laplanche/page/board/board_page.dart';
import 'package:laplanche/page/create_board/create_board_page.dart';
import 'package:laplanche/page/home/allboard_component.dart';
import 'package:laplanche/page/home/categorized_component.dart';
import 'package:laplanche/page/home/recent_component.dart';
import 'package:laplanche/page/search/search_page.dart';
import 'package:laplanche/repository/board_repository.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          BlocProvider(
            create: (context) => MainPageBloc(BoardRepository()),
            child: PageView(
              controller: _pageController,
              children: <Widget>[
                AllBoardComponent(),
                CategorizedComponent(),
                RecentComponent()
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Material(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(icon: Icon(Icons.add), onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CreateBoardPage()));
                      }),
                      IconButton(icon: Icon(Icons.search), onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
                      }),
                      IconButton(icon: Icon(Icons.more_horiz), onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BoardPage()));
                      }),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
