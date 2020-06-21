// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'create_board_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$CreateBoardStateTearOff {
  const _$CreateBoardStateTearOff();

  Initial initial() {
    return const Initial();
  }

  Loading loading(bool isLoading) {
    return Loading(
      isLoading,
    );
  }

  Success success() {
    return const Success();
  }

  ShowMessage showMessage(String message) {
    return ShowMessage(
      message,
    );
  }
}

// ignore: unused_element
const $CreateBoardState = _$CreateBoardStateTearOff();

mixin _$CreateBoardState {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result loading(bool isLoading),
    @required Result success(),
    @required Result showMessage(String message),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result loading(bool isLoading),
    Result success(),
    Result showMessage(String message),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(Initial value),
    @required Result loading(Loading value),
    @required Result success(Success value),
    @required Result showMessage(ShowMessage value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(Initial value),
    Result loading(Loading value),
    Result success(Success value),
    Result showMessage(ShowMessage value),
    @required Result orElse(),
  });
}

abstract class $CreateBoardStateCopyWith<$Res> {
  factory $CreateBoardStateCopyWith(
          CreateBoardState value, $Res Function(CreateBoardState) then) =
      _$CreateBoardStateCopyWithImpl<$Res>;
}

class _$CreateBoardStateCopyWithImpl<$Res>
    implements $CreateBoardStateCopyWith<$Res> {
  _$CreateBoardStateCopyWithImpl(this._value, this._then);

  final CreateBoardState _value;
  // ignore: unused_field
  final $Res Function(CreateBoardState) _then;
}

abstract class $InitialCopyWith<$Res> {
  factory $InitialCopyWith(Initial value, $Res Function(Initial) then) =
      _$InitialCopyWithImpl<$Res>;
}

class _$InitialCopyWithImpl<$Res> extends _$CreateBoardStateCopyWithImpl<$Res>
    implements $InitialCopyWith<$Res> {
  _$InitialCopyWithImpl(Initial _value, $Res Function(Initial) _then)
      : super(_value, (v) => _then(v as Initial));

  @override
  Initial get _value => super._value as Initial;
}

class _$Initial implements Initial {
  const _$Initial();

  @override
  String toString() {
    return 'CreateBoardState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result loading(bool isLoading),
    @required Result success(),
    @required Result showMessage(String message),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(success != null);
    assert(showMessage != null);
    return initial();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result loading(bool isLoading),
    Result success(),
    Result showMessage(String message),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(Initial value),
    @required Result loading(Loading value),
    @required Result success(Success value),
    @required Result showMessage(ShowMessage value),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(success != null);
    assert(showMessage != null);
    return initial(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(Initial value),
    Result loading(Loading value),
    Result success(Success value),
    Result showMessage(ShowMessage value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial implements CreateBoardState {
  const factory Initial() = _$Initial;
}

abstract class $LoadingCopyWith<$Res> {
  factory $LoadingCopyWith(Loading value, $Res Function(Loading) then) =
      _$LoadingCopyWithImpl<$Res>;
  $Res call({bool isLoading});
}

class _$LoadingCopyWithImpl<$Res> extends _$CreateBoardStateCopyWithImpl<$Res>
    implements $LoadingCopyWith<$Res> {
  _$LoadingCopyWithImpl(Loading _value, $Res Function(Loading) _then)
      : super(_value, (v) => _then(v as Loading));

  @override
  Loading get _value => super._value as Loading;

  @override
  $Res call({
    Object isLoading = freezed,
  }) {
    return _then(Loading(
      isLoading == freezed ? _value.isLoading : isLoading as bool,
    ));
  }
}

class _$Loading implements Loading {
  const _$Loading(this.isLoading) : assert(isLoading != null);

  @override
  final bool isLoading;

  @override
  String toString() {
    return 'CreateBoardState.loading(isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Loading &&
            (identical(other.isLoading, isLoading) ||
                const DeepCollectionEquality()
                    .equals(other.isLoading, isLoading)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(isLoading);

  @override
  $LoadingCopyWith<Loading> get copyWith =>
      _$LoadingCopyWithImpl<Loading>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result loading(bool isLoading),
    @required Result success(),
    @required Result showMessage(String message),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(success != null);
    assert(showMessage != null);
    return loading(isLoading);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result loading(bool isLoading),
    Result success(),
    Result showMessage(String message),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading(isLoading);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(Initial value),
    @required Result loading(Loading value),
    @required Result success(Success value),
    @required Result showMessage(ShowMessage value),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(success != null);
    assert(showMessage != null);
    return loading(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(Initial value),
    Result loading(Loading value),
    Result success(Success value),
    Result showMessage(ShowMessage value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading implements CreateBoardState {
  const factory Loading(bool isLoading) = _$Loading;

  bool get isLoading;
  $LoadingCopyWith<Loading> get copyWith;
}

abstract class $SuccessCopyWith<$Res> {
  factory $SuccessCopyWith(Success value, $Res Function(Success) then) =
      _$SuccessCopyWithImpl<$Res>;
}

class _$SuccessCopyWithImpl<$Res> extends _$CreateBoardStateCopyWithImpl<$Res>
    implements $SuccessCopyWith<$Res> {
  _$SuccessCopyWithImpl(Success _value, $Res Function(Success) _then)
      : super(_value, (v) => _then(v as Success));

  @override
  Success get _value => super._value as Success;
}

class _$Success implements Success {
  const _$Success();

  @override
  String toString() {
    return 'CreateBoardState.success()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Success);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result loading(bool isLoading),
    @required Result success(),
    @required Result showMessage(String message),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(success != null);
    assert(showMessage != null);
    return success();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result loading(bool isLoading),
    Result success(),
    Result showMessage(String message),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(Initial value),
    @required Result loading(Loading value),
    @required Result success(Success value),
    @required Result showMessage(ShowMessage value),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(success != null);
    assert(showMessage != null);
    return success(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(Initial value),
    Result loading(Loading value),
    Result success(Success value),
    Result showMessage(ShowMessage value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class Success implements CreateBoardState {
  const factory Success() = _$Success;
}

abstract class $ShowMessageCopyWith<$Res> {
  factory $ShowMessageCopyWith(
          ShowMessage value, $Res Function(ShowMessage) then) =
      _$ShowMessageCopyWithImpl<$Res>;
  $Res call({String message});
}

class _$ShowMessageCopyWithImpl<$Res>
    extends _$CreateBoardStateCopyWithImpl<$Res>
    implements $ShowMessageCopyWith<$Res> {
  _$ShowMessageCopyWithImpl(
      ShowMessage _value, $Res Function(ShowMessage) _then)
      : super(_value, (v) => _then(v as ShowMessage));

  @override
  ShowMessage get _value => super._value as ShowMessage;

  @override
  $Res call({
    Object message = freezed,
  }) {
    return _then(ShowMessage(
      message == freezed ? _value.message : message as String,
    ));
  }
}

class _$ShowMessage implements ShowMessage {
  const _$ShowMessage(this.message) : assert(message != null);

  @override
  final String message;

  @override
  String toString() {
    return 'CreateBoardState.showMessage(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ShowMessage &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @override
  $ShowMessageCopyWith<ShowMessage> get copyWith =>
      _$ShowMessageCopyWithImpl<ShowMessage>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result loading(bool isLoading),
    @required Result success(),
    @required Result showMessage(String message),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(success != null);
    assert(showMessage != null);
    return showMessage(message);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result loading(bool isLoading),
    Result success(),
    Result showMessage(String message),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (showMessage != null) {
      return showMessage(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(Initial value),
    @required Result loading(Loading value),
    @required Result success(Success value),
    @required Result showMessage(ShowMessage value),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(success != null);
    assert(showMessage != null);
    return showMessage(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(Initial value),
    Result loading(Loading value),
    Result success(Success value),
    Result showMessage(ShowMessage value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (showMessage != null) {
      return showMessage(this);
    }
    return orElse();
  }
}

abstract class ShowMessage implements CreateBoardState {
  const factory ShowMessage(String message) = _$ShowMessage;

  String get message;
  $ShowMessageCopyWith<ShowMessage> get copyWith;
}
