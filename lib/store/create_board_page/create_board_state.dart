import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_board_state.freezed.dart';

@freezed
abstract class CreateBoardState with _$CreateBoardState {
  const factory CreateBoardState.initial() = Initial;
  const factory CreateBoardState.loading(bool isLoading) = Loading;
  const factory CreateBoardState.success() = Success;
  const factory CreateBoardState.showMessage(String message) = ShowMessage;
} 