import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 38, left: 16, right: 16),
            child: Text("SEARCH", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          ),
          Container(
            margin: EdgeInsets.only(left:16, right: 16, top:16),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2
              ),                
            ),
            child: TextField(
              maxLines: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "search",
                contentPadding: EdgeInsets.symmetric(horizontal: 8)
              ),
            ),
          )
        ],
      ),
    );
  }
}
