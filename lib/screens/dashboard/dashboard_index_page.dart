import 'package:financial_app/screens/dashboard/dashboard_page.dart';
import 'package:financial_app/services/navigators.dart';
import 'package:flutter/material.dart';

class DashboardIndexPage extends StatelessWidget {
  const DashboardIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: dashboardNavigatorKey,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => const Dashboard(),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => const Dashboard(),
            );
        }
      },
    );
  }
}
