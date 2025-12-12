import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:space_hub/features/auth/presentation/bloc/auth_event.dart';
import 'package:space_hub/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._dio) : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) {
      event.mapOrNull(
        login: (e) => _onLogin(e, emit),
        logout: (e) => _onLogout(e, emit),
        register: (e) => _onRegister(e, emit),
      );
    });
  }

  final Dio _dio;

  Future<void> _onLogin(AuthEvent event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    // TODO: Implement login logic
  }

  Future<void> _onLogout(AuthEvent event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    // TODO: Implement logout logic
    emit(const AuthState.unauthenticated());
  }

  Future<void> _onRegister(AuthEvent event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    // TODO: Implement register logic
  }
}
