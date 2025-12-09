import 'package:freezed_annotation/freezed_annotation.dart';

part 'detailed_state.freezed.dart';

@freezed
class DetailedState with _$DetailedState {
  const factory DetailedState.initial(String id) = _Initial;
  const factory DetailedState.loading() = _Loading;
  const factory DetailedState.loaded() = _Loaded;
  const factory DetailedState.error(String message) = _Error;
}
