import 'package:space_hub/features/test_feature_port/balance_port.dart';

/// Фича "Покупки" знает ТОЛЬКО про BalancePort.
/// Какая именно реализация — неважно (кошелёк, мок, внешний сервис).
class PurchasesService {
  PurchasesService(this._balancePort);

  final BalancePort _balancePort;

  bool canBuy(double price) => _balancePort.balance >= price;

  /// Попытка купить: просто проверяем и "списываем" через кошелёк,
  /// но саму логику списания держим в кошельке — здесь только решение.
  Future<bool> attemptBuy({
    required double price,
    required Future<bool> Function() spend, // передаём действие списания извне
  }) async {
    if (!canBuy(price)) return false;
    return spend(); // конкретное списание реализует владелец кошелька
  }
}
