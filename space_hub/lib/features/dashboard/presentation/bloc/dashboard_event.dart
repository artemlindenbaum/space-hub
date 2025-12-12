import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_event.freezed.dart';

@freezed
class DashboardEvent with _$DashboardEvent {
  const factory DashboardEvent.loadData() = _LoadData;
  const factory DashboardEvent.refresh() = _Refresh;
}
