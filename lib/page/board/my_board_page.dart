import 'package:flutter/material.dart';
import 'package:laplanche/model/board_with_category.dart';

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
      appBar: AppBar(title: Text(this.widget.boardWithCategory.board.name)),
    );
  }
}
