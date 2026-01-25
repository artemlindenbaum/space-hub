import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:space_hub/core/async_status.dart';

part 'profile_state.freezed.dart';

enum ProfileEffect { none }

enum ProfileError { unknown }

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(AsyncIdle())
    AsyncStatus<ProfileError, ProfileEffect> asyncStatus,
    String? supportLink,
  }) = _ProfileState;
}
