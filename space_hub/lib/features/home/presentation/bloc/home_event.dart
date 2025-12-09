import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.freezed.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.loadData() = _LoadData;
  const factory HomeEvent.refresh() = _Refresh;
}
