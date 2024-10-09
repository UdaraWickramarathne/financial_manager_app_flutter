import 'package:financial_app/screens/dashboard/dashboard_index_page.dart';
import 'package:financial_app/screens/profile_pages/profile_index_page.dart';
import 'package:financial_app/screens/transaction/transaction_index_page.dart';
import 'package:financial_app/themes/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
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
              onPressed: () {},
              backgroundColor: Colors.purple,
              shape: const CircleBorder(),
              elevation: 0,
              child: const Icon(Icons.add),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: isDarkMode
            ? BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.12),
                    spreadRadius: 0.5,
                    blurRadius: 20,
                    offset: const Offset(0, 9),
                  ),
                ],
              )
            : BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 0.5,
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
        height: 60,
        child: BottomAppBar(
          elevation: 10.0,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
                left: 20, // Animate the horizontal position
                top: 0.0,
                bottom: 0.0,
                child: IconButton(
                  icon: const Icon(Icons.home),
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
                left: isHome ? 100.0 : 120.0,
                top: 0.0,
                bottom: 0.0,
                child: IconButton(
                  icon: const Icon(Icons.person),
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
                right:
                    isHome ? 100.0 : 120.0, // Animate the horizontal position
                top: 0.0,
                bottom: 0.0,
                child: IconButton(
                  icon: const Icon(Icons.report),
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
      ),
    );
  }
}
