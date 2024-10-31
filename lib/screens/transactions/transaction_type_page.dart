import 'package:financial_app/components/simple_button.dart';
import 'package:financial_app/components/transaction_type_tile.dart';
import 'package:financial_app/screens/transactions/add_expense_page.dart';
import 'package:financial_app/screens/transactions/add_income_page.dart';
import 'package:flutter/material.dart';

class TransactionTypePage extends StatefulWidget {
  const TransactionTypePage({super.key});

  @override
  State<TransactionTypePage> createState() => _TransactionTypePageState();
}

class _TransactionTypePageState extends State<TransactionTypePage> {
  String _selectedType = 'Expense';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 35),
          ),
        ],
        title: const Center(
          child: Text(
            'Transaction',
            style: TextStyle(fontSize: 22),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select your transaction type',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            TransactionTypeTile(
              icon: Icons.book,
              title: 'Expense',
              isSelected: _selectedType == 'Expense',
              onTap: () {
                setState(() {
                  _selectedType = 'Expense';
                });
              },
            ),
            TransactionTypeTile(
              icon: Icons.auto_graph,
              title: 'Income',
              isSelected: _selectedType == 'Income',
              onTap: () {
                setState(() {
                  _selectedType = 'Income';
                });
              },
            ),
            const Spacer(),
            SimpleButton(
              data: 'Next',
              onPressed: () {
                if (_selectedType == 'Expense') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddExpensePage(),
                      ));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddIncomePage(),
                      ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
