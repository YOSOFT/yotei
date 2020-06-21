import 'package:flutter/material.dart';

class RecentComponent extends StatefulWidget {
  @override
  _RecentComponentState createState() => _RecentComponentState();
}

class _RecentComponentState extends State<RecentComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:38, left: 16),
      child: Text("recents", style: TextStyle(fontSize: 48, fontFamily: "Assistant")),
    );
  }
}