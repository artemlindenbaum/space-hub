import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_state.freezed.dart';

enum AuthStatus { unauthorized, authorized }

@freezed
abstract class SessionState with _$SessionState {
  const factory SessionState({
    @Default(AuthStatus.unauthorized) AuthStatus authStatus,
  }) = _SessionState;
}
