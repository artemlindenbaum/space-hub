import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_hub/core/async_status.dart';
import 'package:space_hub/features/dashboard/domain/dashboard_repository.dart';
import 'package:space_hub/features/dashboard/presentation/bloc/dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(this._dashboardRepository) : super(const DashboardState()) {
    _loadData();
  }

  final DashboardRepository _dashboardRepository;

  Future<void> _loadData() async {
    try {
      emit(state.copyWith(asyncStatus: const AsyncLoading()));
      await _dashboardRepository.loadData();
      emit(state.copyWith(asyncStatus: const AsyncIdle()));
    } catch (e) {
      emit(
        state.copyWith(asyncStatus: const AsyncFailure(DashboardError.unknown)),
      );
    }
  }

  void resetState() => emit(const DashboardState());

  void resetAsyncStatus() {
    emit(state.copyWith(asyncStatus: const AsyncIdle()));
  }
}
