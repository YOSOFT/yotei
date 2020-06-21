// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_board_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CreateBoardStore on _CreateBoardStore, Store {
  final _$stateAtom = Atom(name: '_CreateBoardStore.state');

  @override
  CreateBoardState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(CreateBoardState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$_CreateBoardStoreActionController =
      ActionController(name: '_CreateBoardStore');

  @override
  void createBoard(dynamic board) {
    final _$actionInfo = _$_CreateBoardStoreActionController.startAction(
        name: '_CreateBoardStore.createBoard');
    try {
      return super.createBoard(board);
    } finally {
      _$_CreateBoardStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
