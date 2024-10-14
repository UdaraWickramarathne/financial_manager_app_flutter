import 'package:financial_app/screens/dashboard/dashboard_index_page.dart';
import 'package:financial_app/screens/profile_pages/profile_index_page.dart';
import 'package:financial_app/screens/transactions/transaction_index_page.dart';
import 'package:financial_app/screens/transactions/transaction_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isHome = true;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    // final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          DashboardIndexPage(),
          ProfileIndexPage(),
          TransactionIndexPage()
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.primary,
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
                icon: const Icon(Icons.home),
                padding: EdgeInsets.zero,
                color: _currentIndex == 0 ? Colors.grey : Colors.black,
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
                icon: const Icon(Icons.person),
                color: _currentIndex == 1 ? Colors.grey : Colors.black,
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
              right: isHome ? 100.0 : 115.0, // Animate the horizontal position
              top: 0.0,
              bottom: 0.0,
              child: IconButton(
                icon: const Icon(Icons.money),
                color: _currentIndex == 2 ? Colors.grey : Colors.black,
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
                icon: const Icon(Icons.currency_exchange),
                color: _currentIndex == 3 ? Colors.grey : Colors.black,
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
