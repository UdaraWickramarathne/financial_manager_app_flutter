import 'package:financial_app/components/login_singup_button.dart';
import 'package:financial_app/components/transaction_type_tile.dart';
import 'package:financial_app/screens/expense/add_expense_page.dart';
import 'package:financial_app/screens/income/add_income_page.dart';
import 'package:flutter/material.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  String _selectedType = 'Expense';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: Icon(Icons.notifications),
          ),
        ],
        title: const Center(
          child: Text(
            'Transaction',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Type',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
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
              color: Colors.green,
            ),
            const SizedBox(height: 40)
          ],
        ),
      ),
    );
  }
}
