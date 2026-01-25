import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:space_hub/core/async_status.dart';

part 'dashboard_state.freezed.dart';

enum DashboardEffect { none }

enum DashboardError { unknown }

@freezed
abstract class DashboardState with _$DashboardState {
  const factory DashboardState({
    @Default(AsyncIdle())
    AsyncStatus<DashboardError, DashboardEffect> asyncStatus,
  }) = _DashboardState;
}
