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
import 'package:laplanche/data/app_database.dart';
import 'package:laplanche/model/board_with_category.dart';
import 'package:laplanche/model/panel_with_items.dart';
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
  TextEditingController _panelItemTitleController = TextEditingController();
  TextEditingController _panelItemDescController = TextEditingController();
  BoardBloc _boardBloc;
  List<PanelWithItems> panelWithItemsFromDb = [];
  BoardViewController _boardViewController = new BoardViewController();
  List<BoardList> panelWidgets = <BoardList>[];
  List<PanelHeader> headers = List();
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
    _panelItemTitleController.dispose();
    _panelItemDescController.dispose();
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
          cubit: _boardBloc,
          listener: (context, state) {
            if (state is BoardStateShowToast) {
              _showToast(state.message);
            } else if (state is BoardStateRefresh) {
              _fetchPanels();
            } else if (state is BoardStatePanelWithItems) {
              panelWithItemsFromDb.clear();
              panelWithItemsFromDb.addAll(state.panelWithItems);
              _moveFromDbToListAlt();
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

  _displayItemDialog(context, panelId) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add panel item"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _panelItemTitleController,
                  decoration: InputDecoration(hintText: "Title"),
                ),
                TextField(
                    controller: _panelItemDescController,
                    decoration: InputDecoration(hintText: "Description"))
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    if (validatePanelItem()) {
                      String name = _panelItemTitleController.text;
                      String desc = _panelItemDescController.text;
                      PanelItemData panelItemData = PanelItemData(
                          id: null,
                          name: name,
                          description: desc,
                          panelId: panelId,
                          order: null);
                      _boardBloc.add(
                          BoardEventCreatePanelItem(panelId, panelItemData));
                      _resetPanelItemController();
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

  _resetPanelItemController() {
    _panelItemTitleController.clear();
    _panelItemDescController.clear();
  }

  _fetchPanels() {
    _boardBloc.add(
        BoardEventGetPanelWithItems(this.widget.boardWithCategory.board.id));
  }

  _moveFromDbToListAlt() {
    headers.clear();
    panelWithItemsFromDb.forEach((element) => headers.add(PanelHeader(
        element.panelData,
        element.panelData.name,
        [],
        element.panelItemDatas)));
    generateWidget();
  }

  generateWidget() {
    int i = 0;
    panelWidgets.clear();
    headers.forEach((element) {
      panelWidgets.add(BoardList(
        index: i,
        onDropList: (int listIndex, int oldListIndex) {
          whenPanelIsDropped(element, listIndex, oldListIndex);
        },
        items: buildBoardItems(element),
        header: generateHeader(element),
        backgroundColor: Colors.transparent,
      ));
      i++;
    });
  }

  List<Widget> generateHeader(PanelHeader header) {
    return [
      Expanded(
          child: Card(
        child: Padding(
            padding: EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        header.panelData.name +
                            "" +
                            header.panelData.order.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Assistant"),
                      ),
                      Text(
                        header.panelData.description,
                        maxLines: 3,
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.more_horiz),
                        onPressed: () =>
                            _showMenu(context, header.panelData.id))
                  ],
                )
              ],
            )),
      ))
    ];
  }

  List<BoardItem> buildBoardItems(PanelHeader panelHeader) {
    List<BoardItem> items = List();
    panelHeader.panelItemsAlt.forEach((element) {
      items.add(BoardItem(
        onDropItem: (int listIndex, int itemIndex, int oldListIndex,
            int oldItemIndex, BoardItemState state) {
          _whenItemIsDropped(listIndex, itemIndex, oldListIndex, oldItemIndex,
              state, element, panelHeader.panelItemsAlt);
        },
        item: _generateItemWidget(element),
      ));
    });
    return items;
  }

  _whenItemIsDropped(
      int listIndex,
      int itemIndex,
      int oldListIndex,
      int oldItemIndex,
      BoardItemState state,
      PanelItemData panelItemData,
      List<PanelItemData> panelDatas) {
    var old = headers[oldListIndex].panelItemsAlt;
    old.removeAt(oldItemIndex);
    var temp = headers[listIndex].panelItemsAlt;
    int panelId = headers[listIndex].panelData.id;
    PanelItemData pid = panelItemData.copyWith(panelId: panelId);
    temp.insert(itemIndex, pid);
    _updatePanelItemToDatabaseAlt(old, temp);
  }

  _updatePanelItemToDatabaseAlt(List<PanelItemData> oldPanelItems,
      List<PanelItemData> insertedPanelItems) {
    _boardBloc.add(BoardEventUpdatePanelItemPositionAlt(oldPanelItems,
        insertedPanelItems, this.widget.boardWithCategory.board.id));
  }

  Widget _generateItemWidget(PanelItemData item) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 0, top: 8, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name + " [" + item.order.toString() + "]",
                      style: TextStyle(fontSize: 18),
                      overflow: TextOverflow.fade,
                      maxLines: 2),
                  Text(item.description,
                      style: TextStyle(fontSize: 14),
                      overflow: TextOverflow.fade,
                      maxLines: 4)
                ],
              ),
            ),
            IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () => {_askDeletePanelItem(item)})
          ],
        ),
      ),
    );
  }

  _askDeletePanelItem(PanelItemData item) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Approve'),
              onPressed: () {
                _deletePanelItem(item);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool validatePanelItem() {
    if (_panelItemTitleController.text.toString().trim() == '') {
      _showToast("Please fill panel item title");
      return false;
    }
    if (_panelItemDescController.text.toString().trim() == '') {
      _showToast("Please fill panel item description");
      return false;
    }
    return true;
  }

  whenPanelIsDropped(PanelHeader panelHeader, int listIndex, int oldListIndex) {
    if (listIndex != oldListIndex) {
      PanelHeader selectedPanel = headers[oldListIndex];
      headers.removeAt(oldListIndex);
      headers.insert(listIndex, selectedPanel);
      _updatePanelPositionToDatabase();
    }
  }

  _updatePanelPositionToDatabase() {
    List<PanelData> temps = headers.map((e) => e.panelData).toList();
    _boardBloc.add(BoardEventSavePanelPosition(
        temps, this.widget.boardWithCategory.board.id));
  }

  _deletePanelItem(PanelItemData panelItemData) {
    print(panelItemData.name);
    List<PanelItemData> panelItemsToOrder = headers
        .singleWhere((element) => element.panelData.id == panelItemData.panelId)
        .panelItemsAlt;
    panelItemsToOrder.remove(panelItemData);
    _boardBloc.add(BoardEventDeletePanelItem(
        this.widget.boardWithCategory.board.id,
        panelItemData.id,
        panelItemsToOrder));
  }

  _deletePanel(int panelId) {
    PanelHeader selectedPanel =
        headers.singleWhere((element) => element.panelData.id == panelId);
    headers.remove(selectedPanel);
    _boardBloc.add(BoardEventDeletePanel(
        panelId, headers.map((e) => e.panelData).toList()));
  }

  _showMenu(context, int panelId) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              cancelButton: CupertinoActionSheetAction(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              actions: <Widget>[
                CupertinoActionSheetAction(
                  child: Text("Create new item"),
                  onPressed: () {
                    Navigator.pop(context);
                    _displayItemDialog(context, panelId);
                  },
                ),
                CupertinoActionSheetAction(
                  child: Text("Edit this panel"),
                  onPressed: () {
                    print("Edit this panel");
                    Navigator.pop(context);
                  },
                ),
                CupertinoActionSheetAction(
                  child: Text("Delete this panel",
                      style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    _deletePanel(panelId);
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }

  _showToast(String message) => Toast.show(message, context);
}
