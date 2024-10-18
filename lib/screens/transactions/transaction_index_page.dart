import 'package:financial_app/screens/transactions/transaction_page.dart';
import 'package:financial_app/screens/transactions/transactions_list.dart';
import 'package:financial_app/services/navigators.dart';
import 'package:flutter/material.dart';

class TransactionIndexPage extends StatelessWidget {
  const TransactionIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: transactionNavigatorKey,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => const TransactionsList(),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => const TransactionPage(),
            );
        }
      },
    );
  }
}
