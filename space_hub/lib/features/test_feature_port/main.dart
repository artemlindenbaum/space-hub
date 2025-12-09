import 'package:flutter/material.dart';
import 'package:space_hub/features/test_feature_port/purchases_service.dart';
import 'package:space_hub/features/test_feature_port/wallet_service.dart';

void main() {
  // Композиция на уровне app:
  // 1) создаём реальный кошелёк (реализация BalancePort)
  final wallet = WalletService(initial: 10);

  // 2) создаём фичу "покупки", отдавая ей ТОЛЬКО контракт
  final purchases = PurchasesService(wallet);

  runApp(MyApp(wallet: wallet, purchases: purchases));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.wallet, required this.purchases, super.key});
  final WalletService wallet;
  final PurchasesService purchases;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet/Purchases demo',
      home: HomePage(wallet: wallet, purchases: purchases),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({required this.wallet, required this.purchases, super.key});
  final WalletService wallet;
  final PurchasesService purchases;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Stream<double> _balance$ = widget.wallet.balanceStream();
  static const double price = 7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wallet/Purchases')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<double>(
          stream: _balance$,
          initialData: widget.wallet.balance,
          builder: (context, snap) {
            final balance = snap.data ?? 0;
            final canBuy = widget.purchases.canBuy(price);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Balance: \$${balance.toStringAsFixed(2)}'),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => setState(() {
                    widget.wallet.addFunds(5);
                  }),
                  child: const Text(r'Add $5'),
                ),
                const SizedBox(height: 24),
                Text('Item price: \$${price.toStringAsFixed(2)}'),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: canBuy
                      ? () async {
                          final ok = await widget.purchases.attemptBuy(
                            price: price,
                            spend: () async => widget.wallet.trySpend(
                              price,
                            ), // реальное списание
                          );
                          if (!ok && context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Not enough funds')),
                            );
                          }
                          setState(() {});
                        }
                      : null,
                  child: const Text('Buy'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.wallet.dispose();
    super.dispose();
  }
}
