import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_event.freezed.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.load() = _Load;

  const factory ProfileEvent.update({
    required String field,
    required String value,
  }) = _Update;
}
