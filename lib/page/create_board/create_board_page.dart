import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laplanche/bloc/create_board_bloc/create_board_bloc.dart';
import 'package:laplanche/bloc/create_board_bloc/create_board_event.dart';
import 'package:laplanche/bloc/create_board_bloc/create_board_state.dart';
import 'package:laplanche/data/app_database.dart';
import 'package:laplanche/repository/board_repository.dart';
import 'package:toast/toast.dart';

class CreateBoardPage extends StatefulWidget {
  @override
  _CreateBoardPageState createState() => _CreateBoardPageState();
}

class _CreateBoardPageState extends State<CreateBoardPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  CreateBoardBloc _createBoardBloc = CreateBoardBloc(BoardRepository());

  void _showToast(message) => Toast.show(message, context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CreateBoardBloc, CreateBoardState>(
          bloc: _createBoardBloc,
          listener: (context, state) {
            if (state is ShowMessage) {
              _showToast(state.message);
            } else if (state is Success) {
              Navigator.of(context).pop(true);
            }
          },
          builder: (context, state) {
            return Stack(
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
                            child: Text("CREATE BOARD",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
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
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 8)),
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
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 8)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: TextField(
                            controller: _categoryController,
                            maxLines: 1,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "category",
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 8)),
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
                              border:
                                  Border.all(width: 2, color: Colors.white)),
                          child: IconButton(
                              icon: Icon(Icons.save),
                              onPressed: () {
                                var title =
                                    _titleController.text.toString().trim();
                                var desc = _descriptionController.text
                                    .toString()
                                    .trim();
                                var _categoryName =
                                    _categoryController.text.trim();
                                if (title.isEmpty ||
                                    desc.isEmpty ||
                                    _categoryName.isEmpty) {
                                  _showToast(
                                      "Title or description must not be empty");
                                } else {
                                  DateTime now = DateTime.now();
                                  _createBoardBloc.add(Save(
                                      Board(
                                          id: null,
                                          name: title,
                                          category: null,
                                          description: desc,
                                          lastUpdated: now),
                                      _categoryName));
                                }
                              })),
                    ],
                  )),
                ),
                _isLoading(state)
              ],
            );
          }),
    );
  }

  Widget _isLoading(state) {
    if (state is Loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Container();
    }
  }
}
