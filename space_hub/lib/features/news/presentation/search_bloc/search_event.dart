import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_event.freezed.dart';

@freezed
class SearchEvent with _$SearchEvent {
  const factory SearchEvent.search({required String query}) = _Search;

  const factory SearchEvent.clear() = _Clear;
}
