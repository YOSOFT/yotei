import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
  BoardWithCategory currentBoardWithCategory;
  TextEditingController _boardTitleController = TextEditingController();
  TextEditingController _boardDescriptionController = TextEditingController();
  TextEditingController _boardCategoryController = TextEditingController();
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
    currentBoardWithCategory = widget.boardWithCategory;
    _fetchPanels();
    _fetchBoard();
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
        title: Text(currentBoardWithCategory == null
            ? ""
            : currentBoardWithCategory.board.name),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add), onPressed: () => _displayDialog(context)),
          PopupMenuButton<String>(
            onSelected: _onSelectedOptionMenu,
            itemBuilder: (BuildContext context) {
              return {'Edit board', 'Delete board'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice.toLowerCase(),
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
            } else if (state is BoardStateSingleBoardWithCategory) {
              setState(() {
                currentBoardWithCategory = state.bwc;
              });
            } else if (state is BoardStateFinishPage) {
              Navigator.pop(context);
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

  _displayItemDialog(context, panelId, {PanelItemData panelItemData = null}) {
    return showDialog(
        context: context,
        builder: (context) {
          if (panelItemData != null) {
            _panelItemTitleController.text = panelItemData.name;
            _panelItemDescController.text = panelItemData.description;
          }
          return WillPopScope(
            onWillPop: () async {
              _panelItemTitleController.clear();
              _panelItemDescController.clear();
              return true;
            },
            child: AlertDialog(
              title: panelItemData == null ? Text("Add") : Text("Edit"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _panelItemTitleController,
                      decoration: InputDecoration(hintText: "Title"),
                    ),
                    TextField(
                        maxLength: null,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        controller: _panelItemDescController,
                        decoration: InputDecoration(hintText: "Description"))
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      if (validatePanelItem()) {
                        if (panelItemData == null) {
                          String name = _panelItemTitleController.text;
                          String desc = _panelItemDescController.text;
                          PanelItemData panelItemData = PanelItemData(
                              id: null,
                              name: name,
                              description: desc,
                              panelId: panelId,
                              order: null);
                          _boardBloc.add(BoardEventCreatePanelItem(
                              panelId, panelItemData));
                          _resetPanelItemController();
                          _refreshLastUpdated();
                          Navigator.pop(context);
                        } else {
                          PanelItemData pid = panelItemData.copyWith(
                              name: _panelItemTitleController.text.trim(),
                              description:
                                  _panelItemDescController.text.trim());
                          _boardBloc.add(BoardEventUpdatePanelItemValue(
                              pid, this.widget.boardWithCategory.board.id));
                          _resetPanelItemController();
                          _refreshLastUpdated();
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: Text("Save"))
              ],
            ),
          );
        });
  }

  _displayBoardDialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          _boardTitleController.text = currentBoardWithCategory.board.name;
          _boardDescriptionController.text =
              currentBoardWithCategory.board.description;
          _boardCategoryController.text =
              currentBoardWithCategory.boardCategoryData.name.toString();
          return WillPopScope(
            onWillPop: () async {
              _boardTitleController.clear();
              _boardDescriptionController.clear();
              _boardCategoryController.clear();
              return true;
            },
            child: AlertDialog(
              title: Text("Edit"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                        decoration: InputDecoration(hintText: "Board name"),
                        controller: _boardTitleController),
                    TextField(
                        maxLength: null,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        controller: _boardDescriptionController,
                        decoration:
                            InputDecoration(hintText: "Board description")),
                    TextField(
                        controller: _boardCategoryController,
                        decoration: InputDecoration(hintText: "Board category"))
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      if (_boardTitleController.text.trim() == '' ||
                          _boardDescriptionController.text.trim() == '' ||
                          _boardCategoryController.text.trim() == '') {
                        _showToast("Please fill all forms first");
                      } else {
                        Board b = currentBoardWithCategory.board.copyWith(
                            name: _boardTitleController.text.trim(),
                            description:
                                _boardDescriptionController.text.trim());
                        BoardCategoryData cat =
                            currentBoardWithCategory.boardCategoryData.copyWith(
                                name: _boardCategoryController.text.trim());
                        BoardWithCategory bwc = BoardWithCategory(b, cat);
                        _boardBloc.add(BoardEventUpdateBoardValue(bwc));
                          _refreshLastUpdated();
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Save"))
              ],
            ),
          );
        });
  }

  _displayDialog(context, {PanelData pd = null}) {
    return showDialog(
        context: context,
        builder: (context) {
          if (pd != null) {
            _panelTitleController.text = pd.name;
            _panelDescriptionController.text = pd.description;
          }
          return WillPopScope(
            onWillPop: () async {
              _panelTitleController.clear();
              _panelDescriptionController.clear();
              return true;
            },
            child: AlertDialog(
              title: Text(pd == null ? "Add" : "Edit"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(hintText: "Panel title"),
                      controller: _panelTitleController,
                    ),
                    TextField(
                        maxLength: null,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        controller: _panelDescriptionController,
                        decoration:
                            InputDecoration(hintText: "Panel description"))
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      if (_panelTitleController.text.trim() == '' ||
                          _panelDescriptionController.text.trim() == '') {
                        _showToast("Please fill panel title and descrition");
                      } else {
                        if (pd == null) {
                          PanelData panelData = PanelData(
                              id: null,
                              name: _panelTitleController.text.trim(),
                              description:
                                  _panelDescriptionController.text.trim(),
                              boardId: this.widget.boardWithCategory.board.id,
                              order: 1);
                          _boardBloc.add(BoardEventCreatePanel(panelData));
                          _resetPanelController();
                          Navigator.pop(context);
                        } else {
                          PanelData panelData = pd.copyWith(
                              name: _panelTitleController.text.trim(),
                              description:
                                  _panelDescriptionController.text.trim());
                          _boardBloc.add(BoardEventUpdatePanelValue(panelData));
                          _resetPanelController();
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: Text("Save"))
              ],
            ),
          );
        });
  }

  _onSelectedOptionMenu(String menuItem) {
    if (menuItem == "edit board") {
      _displayBoardDialog(context);
    } else {
      _askDeleteBoard();
    }
  }

  _askDeleteBoard() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete board'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Would you like to delete ${currentBoardWithCategory.board.name}?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                _boardBloc.add(BoardEventDeleteBoard(currentBoardWithCategory));
              },
            ),
          ],
        );
      },
    );
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
    _boardBloc.add(BoardEventGetPanelWithItems(this.widget.boardWithCategory.board.id));
  }

  _fetchBoard() {
    _boardBloc
        .add(BoardEventGetSingleBoardWithCategory(currentBoardWithCategory));
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 8, top: 8, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          header.panelData.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Assistant"),
                        ),
                        Text(header.panelData.description,
                            maxLines: 1, overflow: TextOverflow.ellipsis)
                      ],
                    ),
                  ),
                  Positioned.fill(
                      child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                        onTap: () => _showPanelInfoDialog(header.panelData)),
                  ))
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                    icon: Icon(Icons.more_horiz),
                    onPressed: () {
                      _showMenu(context, header.panelData);
                    })
              ],
            )
          ],
        ),
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
    _boardBloc.add(BoardEventUpdatePanelItemPositionAlt(oldPanelItems,insertedPanelItems, this.widget.boardWithCategory.board.id));
    _refreshLastUpdated();
  }

  Widget _generateItemWidget(PanelItemData item) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 0, top: 8, bottom: 8),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name,
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
              Positioned.fill(
                  child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: () => _showPanelItemInfoDialog(item)),
                ))

              ],
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (i) => {
              if (i == "edit")
                {_displayItemDialog(context, item.id, panelItemData: item)}
              else
                {_askDeletePanelItem(item)}
            },
            itemBuilder: (BuildContext context) {
              return {"Edit", "Delete"}.map((el) {
                return PopupMenuItem<String>(
                  value: el.toLowerCase(),
                  child: Text(el),
                );
              }).toList();
            },
          )
        ],
      ),
    );
  }

  _askDeletePanelItem(PanelItemData item) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete item'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Would you like to delete this panel item?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Delete'),
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
    _boardBloc.add(BoardEventSavePanelPosition(temps, this.widget.boardWithCategory.board.id));
    _refreshLastUpdated();
  }

  _deletePanelItem(PanelItemData panelItemData) {
    List<PanelItemData> panelItemsToOrder = headers
        .singleWhere((element) => element.panelData.id == panelItemData.panelId)
        .panelItemsAlt;
    panelItemsToOrder.remove(panelItemData);
    _boardBloc.add(BoardEventDeletePanelItem(
        this.widget.boardWithCategory.board.id,
        panelItemData.id,
        panelItemsToOrder));
    _refreshLastUpdated();
  }

  _deletePanel(int panelId) {
    PanelHeader selectedPanel =
        headers.singleWhere((element) => element.panelData.id == panelId);
    headers.remove(selectedPanel);
    _boardBloc.add(BoardEventDeletePanel(
      this.widget.boardWithCategory.board.id, panelId, headers.map((e) => e.panelData).toList()));
    _refreshLastUpdated();
  }

  _showMenu(context, PanelData panelData) {
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
                    _displayItemDialog(context, panelData.id);
                  },
                ),
                CupertinoActionSheetAction(
                  child: Text("Edit this panel"),
                  onPressed: () {
                    Navigator.pop(context);
                    _displayDialog(context, pd: panelData);
                  },
                ),
                CupertinoActionSheetAction(
                  child: Text("Delete this panel",
                      style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    Navigator.pop(context);
                    _askDeletePanel(panelData.id);
                  },
                ),
              ],
            ));
  }

  _askDeletePanel(panelId) {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Would you like to delete this panel?')
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                _deletePanel(panelId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _showPanelInfoDialog(PanelData panelData) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(panelData.name,
                    style: TextStyle(
                        fontFamily: "Assistant", fontWeight: FontWeight.bold)),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Text(panelData.description),
                )
              ],
            ),
          ));
        });
  }

    _showPanelItemInfoDialog(PanelItemData panelItemData) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(panelItemData.name,
                    style: TextStyle(
                        fontFamily: "Assistant", fontWeight: FontWeight.bold)),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Text(panelItemData.description),
                )
              ],
            ),
          ));
        });
  }

  _refreshLastUpdated(){
    var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
    String formattedDate = formatter.format(DateTime.now());
    DateTime dt = DateTime.parse(formattedDate);
    Board board = this.widget.boardWithCategory.board.copyWith(lastUpdated: dt);
    _boardBloc.add(BoardEventUpdateBoardLastUpdated(board));
  }

  _showToast(String message) => Toast.show(message, context);
}
