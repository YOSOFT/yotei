import 'package:flutter/material.dart';
import 'package:laplanche/data/app_database.dart';
import 'package:laplanche/repository/board_repository.dart';
import 'package:laplanche/store/create_board_page/create_board_state.dart';
import 'package:laplanche/store/create_board_page/create_board_store.dart';
import 'package:mobx/mobx.dart';


class CreateBoardPage extends StatefulWidget {
  @override
  _CreateBoardPageState createState() => _CreateBoardPageState();
}

class _CreateBoardPageState extends State<CreateBoardPage> {
  final _createBoardStore = CreateBoardStore(BoardRepository());
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isLoading = false;

  List<ReactionDisposer> _disposers;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction((_) => _createBoardStore.state, (CreateBoardState state){
        state.when(
          initial: () => print("Inisial"),
          loading: (isLoading) => _isLoading = isLoading,
          success: () => {
            Navigator.pop(context)
          },
          showMessage: (message){
            print(message);
          }
        );
      })
    ];
  }


  @override
  void dispose() {
    _disposers.forEach((d) => d());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: 38),
                      child: Text("CREATE BOARD", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold))),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: TextField(
                      controller: _titleController,
                      maxLines: 1,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "board title",
                          contentPadding: EdgeInsets.symmetric(horizontal: 8)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: TextField(
                      controller: _descriptionController,
                      maxLines: 1,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "short description",
                          contentPadding: EdgeInsets.symmetric(horizontal: 8)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: TextField(
                      maxLines: 1,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "category",
                          contentPadding: EdgeInsets.symmetric(horizontal: 8)),
                    ),
                  )
                ],
              ),
            ),
          ),


          Align(
            alignment: Alignment.bottomCenter,
            child: Material(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2,
                          color: Colors.white
                        )
                      ),
                      child: IconButton(icon: Icon(Icons.save), onPressed: () {
                        var title = _titleController.text.toString().trim();
                        var desc = _descriptionController.text.toString().trim();
                        if(title.isEmpty || desc.isEmpty){
                          print("Title or description must not be empty");
                        }else{
                          DateTime now = DateTime.now();
                          _createBoardStore.createBoard(Board(name: title, description: desc, lastUpdated: now));
                          print("after insert");
                        }

                      })),
                  ],
                )),
          ),

          _isLoading == true ? Center(child: CircularProgressIndicator()) : Container()
          

        ],
      ),
    );
  }
}
