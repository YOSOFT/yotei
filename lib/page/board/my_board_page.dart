import 'package:flutter/material.dart';
import 'package:laplanche/model/board_with_category.dart';
import 'package:toast/toast.dart';

class MyBoardPage extends StatefulWidget {
  final BoardWithCategory boardWithCategory;

  MyBoardPage({Key key, @required this.boardWithCategory}) : super(key: key);
  @override
  _MyBoardPageState createState() => _MyBoardPageState();
}

class _MyBoardPageState extends State<MyBoardPage> {
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
                  onPressed: () => Navigator.pop(context), child: Text("Save"))
            ],
          );
        });
  }

  _onSelectedOptionMenu(String menuItem) {
    _showToast(menuItem);
  }

  _showToast(String message) => Toast.show(message, context);
}
