import 'package:financial_app/screens/convertor/money_converor.dart';
import 'package:financial_app/screens/dashboard/dashboard_page.dart';
import 'package:financial_app/screens/profile_pages/profile_index_page.dart';
import 'package:financial_app/screens/transactions/transaction_index_page.dart';
import 'package:financial_app/screens/transactions/transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:transitioned_indexed_stack/transitioned_indexed_stack.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isHome = true;
  int _currentIndex = 0;

  final String _exchane = 'assets/icons/exchange.ico';
  final String _exchaneOut = 'assets/icons/exchange_out.ico';
  final String _transaction = 'assets/icons/transaction.png';
  final String _transactionOut = 'assets/icons/transaction_out.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeIndexedStack(
        index: _currentIndex,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 200),
        children: const [
          Dashboard(),
          ProfileIndexPage(),
          TransactionIndexPage(),
          MoneyConveror(),
        ],
      ),
      floatingActionButton: isHome
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TransactionPage(),
                    ));
              },
              backgroundColor: const Color(0xFF456EFE),
              shape: const CircleBorder(),
              elevation: 0,
              child: const Icon(Icons.add),
            )
          : null,
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).bottomAppBarTheme.color,
        height: 60,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
              left: 20,
              top: 0.0,
              bottom: 0.0,
              child: IconButton(
                icon: Icon(
                  _currentIndex == 0 ? Icons.home : Icons.home_outlined,
                ),
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    isHome = true;
                    _currentIndex = 0;
                  });
                },
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
              left: isHome ? 100.0 : 115.0,
              top: 0.0,
              bottom: 0.0,
              child: IconButton(
                icon: Icon(
                  _currentIndex == 1 ? Icons.person : Icons.person_outline,
                ),
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    isHome = false;
                    _currentIndex = 1;
                  });
                },
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
              right: isHome ? 100.0 : 115.0,
              top: 0.0,
              bottom: 0.0,
              child: IconButton(
                icon: ImageIcon(
                  AssetImage(
                    _currentIndex == 2 ? _transaction : _transactionOut,
                  ),
                  size: 24,
                ),
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    isHome = false;
                    _currentIndex = 2;
                  });
                },
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
              right: 20.0,
              top: 0.0,
              bottom: 0.0,
              child: IconButton(
                icon: ImageIcon(
                  AssetImage(
                    _currentIndex == 3 ? _exchane : _exchaneOut,
                  ),
                ),
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    isHome = false;
                    _currentIndex = 3;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
