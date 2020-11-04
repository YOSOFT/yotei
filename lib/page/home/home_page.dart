import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laplanche/bloc/main_page_bloc/main_page_bloc.dart';
import 'package:laplanche/bloc/main_page_bloc/main_page_event.dart';
import 'package:laplanche/data/app_database.dart';
import 'package:laplanche/page/about/about_page.dart';
import 'package:laplanche/page/create_board/create_board_page.dart';
import 'package:laplanche/page/home/allboard_component.dart';
import 'package:laplanche/page/home/categorized_component.dart';
import 'package:laplanche/page/search/search_page.dart';
import 'package:laplanche/repository/board_repository.dart';
import 'package:laplanche/utils/injector.dart';

typedef DataCallback = void Function();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController(initialPage: 0);
  MainPageBloc _mainPageBloc;

  @override
  void initState() {
    _mainPageBloc = MainPageBloc(BoardRepository(locator<AppDatabase>()));
    super.initState();
  }

  void _fetchBoard() {
    _mainPageBloc.add(GetAllByCategory());
    _mainPageBloc.add(GetAll());
  }

  @override
  void didChangeDependencies() {
    _fetchBoard();
    super.didChangeDependencies();
  }

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
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => _mainPageBloc),
            ],
            child: Container(
              margin: EdgeInsets.only(bottom: 50),
              child: PageView(
                controller: _pageController,
                children: <Widget>[
                  AllBoardComponent(
                    dataCallback: () => {_fetchBoard()},
                  ),
                  CategorizedComponent(dataCallback: () => {_fetchBoard()}),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Material(
                child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateBoardPage()))
                            .then((value) {
                          _fetchBoard();
                        });
                      }),
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchPage())).then((value) => _fetchBoard());
                      }),
                  IconButton(
                      icon: Icon(Icons.more_horiz),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutPage()));
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
