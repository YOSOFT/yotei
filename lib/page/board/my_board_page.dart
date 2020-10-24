import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/cupertino.dart';
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
  TextEditingController _panelTitleController = TextEditingController();
  TextEditingController _panelDescriptionController = TextEditingController();
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
  void dispose() {
    _panelTitleController.dispose();
    _panelDescriptionController.dispose();
    super.dispose();
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
            } else if (state is BoardStateRefresh) {
              _fetchPanels();
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

  _displayItemDialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add or edit"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: "Title"),
                ),
                TextField(decoration: InputDecoration(hintText: "Description"))
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    if (_panelTitleController.text.trim() == '' ||
                        _panelDescriptionController.text.trim() == '') {
                      _showToast("Please fill panel title and descrition");
                    } else {
                      PanelData panelData = PanelData(
                          id: null,
                          name: _panelTitleController.text.trim(),
                          description: _panelDescriptionController.text.trim(),
                          boardId: this.widget.boardWithCategory.board.id,
                          order: 1);
                      _boardBloc.add(BoardEventCreatePanel(panelData));
                      _resetPanelController();
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Save"))
            ],
          );
        });
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
                TextField(
                  decoration: InputDecoration(hintText: "Panel title"),
                  controller: _panelTitleController,
                ),
                TextField(
                    controller: _panelDescriptionController,
                    decoration: InputDecoration(hintText: "Panel description"))
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    if (_panelTitleController.text.trim() == '' ||
                        _panelDescriptionController.text.trim() == '') {
                      _showToast("Please fill panel title and descrition");
                    } else {
                      PanelData panelData = PanelData(
                          id: null,
                          name: _panelTitleController.text.trim(),
                          description: _panelDescriptionController.text.trim(),
                          boardId: this.widget.boardWithCategory.board.id,
                          order: 1);
                      _boardBloc.add(BoardEventCreatePanel(panelData));
                      _resetPanelController();
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Save"))
            ],
          );
        });
  }

  _onSelectedOptionMenu(String menuItem) {
    _showToast(menuItem);
  }

  _resetPanelController() {
    _panelTitleController.clear();
    _panelDescriptionController.clear();
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
          child: Card(
        child: Padding(
            padding: EdgeInsets.only(left: 16, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  header.title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Assistant"),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => {_displayItemDialog(context)}),
                )
              ],
            )),
      ))
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
