import 'package:boardview/board_list.dart';
import 'package:boardview/boardview.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laplanche/bloc/board_bloc/board_bloc.dart';
import 'package:laplanche/bloc/board_bloc/board_event.dart';
import 'package:laplanche/bloc/board_bloc/board_state.dart';
import 'package:laplanche/components/panel_header.dart';
import 'package:laplanche/data/app_database.dart';
import 'package:laplanche/model/board_with_category.dart';
import 'package:laplanche/repository/board_repository.dart';
import 'package:laplanche/utils/injector.dart';
import 'package:toast/toast.dart';

class MyBoardPage extends StatefulWidget {
  final BoardWithCategory boardWithCategory;

  MyBoardPage({Key key, @required this.boardWithCategory}) : super(key: key);
  @override
  _MyBoardPageState createState() => _MyBoardPageState();
}

class _MyBoardPageState extends State<MyBoardPage> {
  BoardBloc _boardBloc;
  List<PanelData> panels = [];
  BoardViewController _boardViewController = new BoardViewController();
  List<BoardList> panelWidgets = <BoardList>[];

  @override
  void initState() {
    _boardBloc = BoardBloc(BoardRepository(locator<AppDatabase>()));
    _fetchPanels();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _fetchPanels();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.boardWithCategory.board.name),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add), onPressed: () => _displayDialog(context)),
          PopupMenuButton<String>(
            onSelected: _onSelectedOptionMenu,
            itemBuilder: (BuildContext context) {
              return {'Edit board', 'Delete board'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: BlocConsumer<BoardBloc, BoardState>(
          bloc: _boardBloc,
          listener: (context, state) {
            if (state is BoardStatePanelsLoaded) {
              panels.clear();
              panels.addAll(state.panels);
            } else if (state is BoardStateShowToast) {
              _showToast(state.message);
            }
          },
          builder: (context, state) {
            return BoardView(
              boardViewController: _boardViewController,
              lists: [],
            );
          }),
    );
  }

  _displayDialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add or edit"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(decoration: InputDecoration(hintText: "Panel title")),
                TextField(
                    decoration: InputDecoration(hintText: "Panel description"))
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    PanelData panelData = PanelData(
                        id: null,
                        name: "Lorem ipsum",
                        description: "Lorem ipsum dolor sit amet consectetur",
                        boardId: this.widget.boardWithCategory.board.id,
                        order: 1);
                    _boardBloc.add(BoardEventCreatePanel(panelData));
                    Navigator.pop(context);
                  },
                  child: Text("Save"))
            ],
          );
        });
  }

  _onSelectedOptionMenu(String menuItem) {
    _showToast(menuItem);
  }

  _fetchPanels() {
    _boardBloc
        .add(BoardEventGetAllPanels(this.widget.boardWithCategory.board.id));
  }

  _createPanelsHeader() {
    List headers = <PanelHeaderComponent>[];
    panels.forEach((p) {
      headers.add(PanelHeaderComponent(p.name, []));
    });
  }

  _showToast(String message) => Toast.show(message, context);
}
