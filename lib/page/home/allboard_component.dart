import 'package:flutter/material.dart';

class AllBoardComponent extends StatefulWidget {
  @override
  _AllBoardComponentState createState() => _AllBoardComponentState();
}

class _AllBoardComponentState extends State<AllBoardComponent> {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:38, left: 16),
      child: Text("all board", style: TextStyle(fontSize: 48, fontFamily: "Assistant")),
    );
  }
}