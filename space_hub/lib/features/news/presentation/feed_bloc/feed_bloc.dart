import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:space_hub/features/news/presentation/feed_bloc/feed_event.dart';
import 'package:space_hub/features/news/presentation/feed_bloc/feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc(this._dio) : super(const FeedState.initial()) {
    on<FeedEvent>((event, emit) {
      event.mapOrNull(
        load: (e) => _onLoad(e, emit),
        refresh: (e) => _onRefresh(e, emit),
      );
    });
  }

  final Dio _dio;

  Future<void> _onLoad(FeedEvent event, Emitter<FeedState> emit) async {
    emit(const FeedState.loading());
    // TODO: Implement load logic
  }

  Future<void> _onRefresh(FeedEvent event, Emitter<FeedState> emit) async {
    emit(const FeedState.loading());
    // TODO: Implement refresh logic
  }
}
