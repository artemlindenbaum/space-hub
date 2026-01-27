import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:space_hub/core/exceptions.dart';
import 'package:space_hub/core/services/session_service/domain/session_repository.dart';
import 'package:space_hub/core/services/session_service/notifier/session_state.dart';

class SessionService extends ChangeNotifier {
  SessionService(this._sessionRepository);

  final SessionRepository _sessionRepository;

  SessionState _state = const SessionState();
  SessionState get state => _state;

  Future<void> initializeSession() async {
    try {
      await refreshTokens();
    } catch (_) {
      _setState(_state.copyWith(authStatus: AuthStatus.unauthorized));
    }
  }

  // authRequired: false
  Future<void> authorize() async {
    await _sessionRepository.authorize();

    _setState(_state.copyWith(authStatus: AuthStatus.authorized));
  }

  Future<void> refreshTokens() async {
    try {
      await _sessionRepository.refreshTokens();

      _setState(_state.copyWith(authStatus: AuthStatus.authorized));
    } on AppUnauthorizedException {
      _setState(_state.copyWith(authStatus: AuthStatus.unauthorized));
    }
  }

  // authRequired: true
  Future<void> deleteUser() async {
    try {
      await _sessionRepository.deleteUser();

      _setState(_state.copyWith(authStatus: AuthStatus.unauthorized));
    } on AppUnauthorizedException {
      _setState(_state.copyWith(authStatus: AuthStatus.unauthorized));
    }
  }

  Future<void> logOut({required bool local}) async {
    try {
      await _sessionRepository.logOut();
      // ignore: avoid_redundant_argument_values
      _setState(const SessionState(authStatus: AuthStatus.unauthorized));
    } catch (e) {
      rethrow;
    }
  }

  void _setState(SessionState next) {
    _state = next;
    notifyListeners();
  }
}
