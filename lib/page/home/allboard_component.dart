import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laplanche/bloc/main_page_bloc/main_page_bloc.dart';
import 'package:laplanche/bloc/main_page_bloc/main_page_state.dart';
import 'package:laplanche/data/app_database.dart';
import 'package:toast/toast.dart';

class AllBoardComponent extends StatefulWidget {
  @override
  _AllBoardComponentState createState() => _AllBoardComponentState();
}

class _AllBoardComponentState extends State<AllBoardComponent>
    with AutomaticKeepAliveClientMixin<AllBoardComponent> {
  List<Board> _boards = List();
  MainPageBloc _mainPageBloc;

  @override
  void initState() {
    _mainPageBloc = BlocProvider.of<MainPageBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: EdgeInsets.only(top: 38),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: Text("yotei",
                style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Assistant")),
          ),
          BlocConsumer<MainPageBloc, MainPageState>(
            bloc: _mainPageBloc,
            listener: (context, state) {
              if (state is ShowMessage) {
                _showMessage(state.message);
              } else if (state is AllBoard) {
                _boards.clear();
                _boards.addAll(state.allBoard);
              }
            },
            builder: (contex, state) {
              return Expanded(
                child: Stack(
                  children: <Widget>[_createBoardList(), _isLoading(state)],
                ),
              );
            },
          )
        ],
      ),
    );
  }

  void _showMessage(message) => Toast.show(message, context);

  Widget _isLoading(state) {
    if (state is MainPageLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Container();
    }
  }

  Widget _createBoardList() {
    if (_boards.isNotEmpty) {
      return ListView.builder(
          physics: ClampingScrollPhysics(),
          itemCount: _boards.length,
          itemBuilder: (context, index) {
            Board board = _boards[index];
            return Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  InkWell(
                    onTap: () => print("llll"),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${board.name}",
                            style: TextStyle(
                                fontFamily: "Assistant",
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${board.description}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                              fontFamily: "Assistant",
                            ),
                          ),
                          Text(
                            "${board.category}",
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
    return Center(
      child: Text("Nothing for now"),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
