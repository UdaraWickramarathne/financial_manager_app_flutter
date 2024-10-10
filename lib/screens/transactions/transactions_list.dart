import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
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
            'All Transactions',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
