import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
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
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
