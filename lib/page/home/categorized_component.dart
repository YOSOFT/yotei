import 'package:flutter/material.dart';

class CategorizedComponent extends StatefulWidget {
  @override
  _CategorizedComponentState createState() => _CategorizedComponentState();
}

class _CategorizedComponentState extends State<CategorizedComponent> {
  @override
  Widget build(BuildContext context) {
   return Container(
      margin: EdgeInsets.only(top:38, left: 16),
      child: Text("by category", style: TextStyle(fontSize: 48, fontFamily: "Assistant")),
    );
  }
}