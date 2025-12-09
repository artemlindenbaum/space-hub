import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:space_hub/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:space_hub/features/dashboard/presentation/bloc/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc(this._dio) : super(const DashboardState.initial()) {
    on<DashboardEvent>((event, emit) {
      event.mapOrNull(
        loadData: (e) => _onLoadData(e, emit),
        refresh: (e) => _onRefresh(e, emit),
      );
    });
  }

  final Dio _dio;

  Future<void> _onLoadData(
    DashboardEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(const DashboardState.loading());
    // TODO: Implement data loading logic
  }

  Future<void> _onRefresh(
    DashboardEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(const DashboardState.loading());
    // TODO: Implement refresh logic with _dio
  }
}
