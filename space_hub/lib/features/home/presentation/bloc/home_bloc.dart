import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:space_hub/features/home/presentation/bloc/home_event.dart';
import 'package:space_hub/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._dio) : super(const HomeState.initial()) {
    on<HomeEvent>((event, emit) {
      event.mapOrNull(
        loadData: (e) => _onLoadData(e, emit),
        refresh: (e) => _onRefresh(e, emit),
      );
    });
  }

  final Dio _dio;

  Future<void> _onLoadData(HomeEvent event, Emitter<HomeState> emit) async {
    emit(const HomeState.loading());
    // TODO: Implement data loading logic
  }

  Future<void> _onRefresh(HomeEvent event, Emitter<HomeState> emit) async {
    emit(const HomeState.loading());
    // TODO: Implement refresh logic with _dio
  }
}
