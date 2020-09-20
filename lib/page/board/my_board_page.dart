import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laplanche/bloc/board_bloc/board_bloc.dart';
import 'package:laplanche/bloc/board_bloc/board_event.dart';
import 'package:laplanche/bloc/board_bloc/board_state.dart';
import 'package:laplanche/components/panel_header.dart';
import 'package:laplanche/components/penal_item.dart';
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
  List<PanelData> panelsFromDb = List();
  BoardViewController _boardViewController = new BoardViewController();
  List<BoardList> panelWidgets = <BoardList>[];
  var brighthness = SchedulerBinding.instance.window.platformBrightness;

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
              panelsFromDb.clear();
              panelsFromDb.addAll(state.panels);
              _moveFromDbToList();
            } else if (state is BoardStateShowToast) {
              _showToast(state.message);
            }
          },
          builder: (context, state) {
            return BoardView(
              lists: panelWidgets,
              boardViewController: _boardViewController,
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

  _moveFromDbToList() {
    List<PanelHeader> headers = List();
    panelsFromDb
        .forEach((element) => headers.add(PanelHeader(element.name, [])));

    int i = 0;
    panelWidgets.clear();
    headers.forEach((element) {
      panelWidgets.add(BoardList(
        index: i,
        items: buildBoardItems(element.getPanelItems),
        header: generateHeader(element),
        backgroundColor: Colors.transparent,
      ));
    });
  }

  List<Widget> generateHeader(PanelHeader header) {
    return [
      Expanded(
          child: Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Text(
                header.title,
                style: TextStyle(fontSize: 48, fontFamily: "Assistant"),
              )))
    ];
  }

  List<BoardItem> buildBoardItems(List<PanelItem> panelItems) {
    List<BoardItem> items = List();
    panelItems.forEach((element) {
      items.add(BoardItem(
        item: _generateItemWidget(element),
      ));
    });
    return items;
  }

  Widget _generateItemWidget(PanelItem item) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          item.itemTitle,
          style: TextStyle(fontSize: 39, color: Colors.blue),
        ),
      ),
    );
  }

  _showToast(String message) => Toast.show(message, context);
}
