import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_hub/core/async_status.dart';
import 'package:space_hub/features/auth/domain/auth_repository.dart';
import 'package:space_hub/features/auth/presentation/bloc/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(const AuthState()) {
    _loadUser();
  }

  final AuthRepository _authRepository;

  Future<void> _loadUser() async {
    try {
      emit(state.copyWith(asyncStatus: const AsyncLoading()));
      await _authRepository.loadUser();
      emit(state.copyWith(asyncStatus: const AsyncIdle()));
    } catch (e) {
      emit(state.copyWith(asyncStatus: const AsyncFailure(AuthError.unknown)));
    }
  }

  void resetState() => emit(const AuthState());

  void resetAsyncStatus() {
    emit(state.copyWith(asyncStatus: const AsyncIdle()));
  }
}
