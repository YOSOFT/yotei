import 'package:flutter/material.dart';
import 'package:laplanche/model/board_with_category.dart';
import 'package:laplanche/page/board/my_board_page.dart';

class BoardListItem extends StatelessWidget {
  final List<BoardWithCategory> _boards;

  BoardListItem(this._boards);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: ClampingScrollPhysics(),
        itemCount: _boards.length,
        itemBuilder: (context, index) {
          BoardWithCategory board = _boards[index];
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                InkWell(
                  onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MyBoardPage(boardWithCategory: _boards[index]);
                    }))
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${board.board.name}",
                          style: TextStyle(
                              fontFamily: "Assistant",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${board.board.description}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                            fontFamily: "Assistant",
                          ),
                        ),
                        Text(
                          "${board.boardCategoryData.name}",
                          style: TextStyle(fontFamily: "Assistant"),
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Text("Date")),
                      ],
                    ),
                  ),
                ),
                Divider()
              ],
            ),
          );
        });
  }
}
