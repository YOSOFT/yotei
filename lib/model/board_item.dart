import 'dart:core';

class MyBoardItem {
  int id;
  String title;

  MyBoardItem();

  MyBoardItem.all(int id,String title){
    this.id = id;
    this.title = title;
  }
}