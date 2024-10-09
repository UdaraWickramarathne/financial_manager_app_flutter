import 'package:financial_app/screens/profile_pages/profile_page.dart';
import 'package:financial_app/services/navigators.dart';
import 'package:flutter/material.dart';

class ProfileIndexPage extends StatelessWidget {
  const ProfileIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: profileNavigatorKey,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => const ProfilePage(),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => const ProfilePage(),
            );
        }
      },
    );
  }
}
