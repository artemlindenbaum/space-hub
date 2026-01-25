import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_hub/core/async_status.dart';
import 'package:space_hub/features/news/domain/news_repository.dart';
import 'package:space_hub/features/news/presentation/bloc/news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit(this._newsRepository) : super(const NewsState());

  final NewsRepository _newsRepository;

  Future<void> loadNewsDetails(String newsId) async {
    try {
      emit(state.copyWith(asyncStatus: const AsyncLoading(), newsId: newsId));
      await _newsRepository.getNewsDetails(newsId);
      emit(state.copyWith(asyncStatus: const AsyncIdle()));
    } catch (e) {
      emit(
        state.copyWith(asyncStatus: const AsyncFailure(NewsError.unknown)),
      );
    }
  }

  void resetState() => emit(const NewsState());

  void resetAsyncStatus() {
    emit(state.copyWith(asyncStatus: const AsyncIdle()));
  }
}
