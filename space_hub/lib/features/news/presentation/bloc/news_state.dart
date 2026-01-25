import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:space_hub/core/async_status.dart';

part 'news_state.freezed.dart';

enum NewsEffect { none }

enum NewsError { unknown }

@freezed
abstract class NewsState with _$NewsState {
  const factory NewsState({
    @Default(AsyncIdle())
    AsyncStatus<NewsError, NewsEffect> asyncStatus,
    String? newsId,
  }) = _NewsState;
}
