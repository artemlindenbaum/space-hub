import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:space_hub/features/news/presentation/search_bloc/search_event.dart';
import 'package:space_hub/features/news/presentation/search_bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this._dio) : super(const SearchState.initial()) {
    on<SearchEvent>((event, emit) {
      event.mapOrNull(
        search: (e) => _onSearch(e, emit),
        clear: (e) => _onClear(e, emit),
      );
    });
  }

  final Dio _dio;

  Future<void> _onSearch(SearchEvent event, Emitter<SearchState> emit) async {
    emit(const SearchState.loading());
    // TODO: Implement search logic
  }

  Future<void> _onClear(SearchEvent event, Emitter<SearchState> emit) async {
    emit(const SearchState.initial());
  }
}
