import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import 'package:laplanche/model/board_item_object.dart';
import 'package:laplanche/model/board_list_object.dart';

class BoardPage extends StatefulWidget {
  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  List<BoardListObject> _listData = [
    BoardListObject(title: "lorem"),
    BoardListObject(title: "ipsum"),
    BoardListObject(title: "dolor sit")
  ];

  //Can be used to animate to different sections of the BoardView
  BoardViewController boardViewController = new BoardViewController();

  @override
  Widget build(BuildContext context) {
    List<BoardList> _lists = List<BoardList>();
    for (int i = 0; i < _listData.length; i++) {
      _lists.add(_createBoardList(_listData[i]));
    }
    return Scaffold(
      body: BoardView(
        lists: _lists,
        boardViewController: boardViewController,
      ),
    );
  }

  Widget buildBoardItem(BoardItemObject itemObject) {
    return BoardItem(
        onStartDragItem:
            (int listIndex, int itemIndex, BoardItemState state) {},
        onDropItem: (int listIndex, int itemIndex, int oldListIndex,
            int oldItemIndex, BoardItemState state) {
          //Used to update our local item data
          var item = _listData[oldListIndex].items[oldItemIndex];
          _listData[oldListIndex].items.removeAt(oldItemIndex);
          _listData[listIndex].items.insert(itemIndex, item);
        },
        onTapItem: (int listIndex, int itemIndex, BoardItemState state) async {
          print("Ashiap");
        },
        item: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              itemObject.title,
              style: TextStyle(fontSize: 39, color: Colors.blue),
            ),
          ),
        ));
  }

  Widget _createBoardList(BoardListObject list) {
    List<BoardItemObject> contents = [];
    for (int x = 0; x < 10; x++) {
      contents.add(BoardItemObject());
    }
    list.items = contents;

    List<BoardItem> anitems = new List();
    for (int i = 0; i < list.items.length; i++) {
      anitems.insert(i, buildBoardItem(list.items[i]));
    }
    return BoardList(
      onStartDragList: (int listIndex) {},
      onTapList: (int listIndex) async {},
      onDropList: (int listIndex, int oldListIndex) {
        //Update our local list data
        var list = _listData[oldListIndex];
        _listData.removeAt(oldListIndex);
        _listData.insert(listIndex, list);
      },
      backgroundColor: Colors.transparent,
      header: [
        Expanded(
            child: Padding(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Text(
                  list.title,
                  style: TextStyle(fontSize: 48, fontFamily: "Assistant"),
                ))),
      ],
      items: anitems,
    );
  }
}
