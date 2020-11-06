import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:laplanche/bloc/create_board_bloc/create_board_bloc.dart';
import 'package:laplanche/bloc/create_board_bloc/create_board_event.dart';
import 'package:laplanche/bloc/create_board_bloc/create_board_state.dart';
import 'package:laplanche/data/app_database.dart';
import 'package:laplanche/repository/board_repository.dart';
import 'package:laplanche/utils/injector.dart';
import 'package:toast/toast.dart';

class CreateBoardPage extends StatefulWidget {
  @override
  _CreateBoardPageState createState() => _CreateBoardPageState();
}

class _CreateBoardPageState extends State<CreateBoardPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  CreateBoardBloc _createBoardBloc =
      CreateBoardBloc(BoardRepository(locator<AppDatabase>()));

  void _showToast(message) => Toast.show(message, context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CreateBoardBloc, CreateBoardState>(
          cubit: _createBoardBloc,
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
                          child: TextField(
                            controller: _titleController,
                            maxLines: 1,
                            decoration: InputDecoration(
                                hintText: "title",
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: TextField(
                            controller: _descriptionController,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                hintText: "short description",),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: TextField(
                            controller: _categoryController,
                            maxLines: 1,
                            decoration: InputDecoration(
                                hintText: "category"
                            ),
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
                                  var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
                                  String formattedDate = formatter.format(DateTime.now());
                                  DateTime dt = DateTime.parse(formattedDate);
                                  _createBoardBloc.add(Save(
                                      Board(
                                          id: null,
                                          name: title,
                                          category: null,
                                          description: desc,
                                          lastUpdated: dt),
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
