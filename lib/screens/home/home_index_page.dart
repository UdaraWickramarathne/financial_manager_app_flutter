import 'package:financial_app/screens/goals/goal_page.dart';
import 'package:financial_app/screens/home/home_page.dart';
import 'package:financial_app/services/navigators.dart';
import 'package:flutter/material.dart';

class HomeIndexPage extends StatelessWidget {
  const HomeIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: globalNavigatorKey,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => const HomePage(),
            );
          case '/goals':
            return MaterialPageRoute(
              builder: (context) => const GoalPage(),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => const HomePage(),
            );
        }
      },
    );
  }
}
