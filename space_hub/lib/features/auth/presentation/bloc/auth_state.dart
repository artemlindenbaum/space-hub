import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:space_hub/core/async_status.dart';

part 'auth_state.freezed.dart';

enum AuthEffect { none }

enum AuthError { unknown }

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AsyncIdle()) AsyncStatus<AuthError, AuthEffect> asyncStatus,
  }) = _AuthState;
}
