import 'package:financial_app/screens/dashboard/dashboard_index_page.dart';
import 'package:financial_app/screens/profile_pages/profile_index_page.dart';
import 'package:financial_app/services/navigators.dart';
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
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          DashboardIndexPage(),
          ProfileIndexPage(),
        ],
      ),
      floatingActionButton: isHome
          ? FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.purple,
              shape: const CircleBorder(),
              child: const Icon(Icons.add),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 0.5,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ]),
        height: 60,
        child: BottomAppBar(
          elevation: 10.0,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  setState(() {
                    isHome = true;
                    _currentIndex = 0;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  setState(() {
                    isHome = false;
                    _currentIndex = 1;
                  });
                },
              ),
              if (isHome)
                const IconButton(
                  icon: Icon(null),
                  onPressed: null,
                ),
              IconButton(
                icon: const Icon(Icons.report),
                onPressed: () {
                  setState(() {
                    isHome = false;
                    _currentIndex = 2;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.currency_exchange),
                onPressed: () {
                  setState(() {
                    isHome = false;
                    _currentIndex = 3;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
