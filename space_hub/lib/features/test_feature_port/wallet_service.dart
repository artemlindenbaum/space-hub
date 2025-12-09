import 'dart:async';

import 'package:space_hub/features/test_feature_port/balance_port.dart';

/// Простейшая реализация кошелька.
/// В реальном мире тут будет API, кэш и т.д.
class WalletService implements BalancePort {
  WalletService({double initial = 0})
    : _balance = initial,
      _controller = StreamController<double>.broadcast() {
    _controller.add(_balance);
  }

  double _balance;
  final StreamController<double> _controller;

  @override
  double get balance => _balance;

  @override
  Stream<double> balanceStream() => _controller.stream;

  void addFunds(double amount) {
    _balance += amount;
    _controller.add(_balance);
  }

  bool trySpend(double amount) {
    if (_balance >= amount) {
      _balance -= amount;
      _controller.add(_balance);
      return true;
    }
    return false;
  }

  void dispose() => _controller.close();
}
