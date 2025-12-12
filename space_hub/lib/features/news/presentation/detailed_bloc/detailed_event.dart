import 'package:freezed_annotation/freezed_annotation.dart';

part 'detailed_event.freezed.dart';

@freezed
class DetailedEvent with _$DetailedEvent {
  const factory DetailedEvent.load({required String id}) = _Load;

  const factory DetailedEvent.refresh() = _Refresh;
}
