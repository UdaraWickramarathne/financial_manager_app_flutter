import 'package:financial_app/themes/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 30),
          child: Icon(Icons.grid_view_rounded),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: Icon(Icons.notifications),
          ),
        ],
        title: const Center(
          child: Text(
            'Transactions',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Switch(
              value: isDarkMode,
              onChanged: (value) {
                themeProvider
                    .toggleTheme(value); // Toggle theme mode on switch change
              },
            ),
          ],
        ),
      ),
    );
  }
}
