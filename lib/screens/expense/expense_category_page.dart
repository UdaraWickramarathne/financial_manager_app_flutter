import 'package:financial_app/components/login_singup_button.dart';
import 'package:flutter/material.dart';

class ExpenseCategoryPage extends StatefulWidget {
  const ExpenseCategoryPage({super.key});

  @override
  State<ExpenseCategoryPage> createState() => _ExpenseCategoryPageState();
}

class _ExpenseCategoryPageState extends State<ExpenseCategoryPage> {
  String? selectedCategory;

  final List<Map<String, String>> categories = [
    {'name': 'Food', 'icon': '🍎'},
    {'name': 'Sport', 'icon': '🏀'},
    {'name': 'Health', 'icon': '💊'},
    {'name': 'Transport', 'icon': '🚌'},
    {'name': 'Shopping', 'icon': '🛍️'},
    {'name': 'Kids', 'icon': '🧸'},
    {'name': 'Entertainment', 'icon': '🎮'},
    {'name': 'Another', 'icon': '🔍'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select the Expense Categorie',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: categories.map((category) {
                return ChoiceChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(category['icon'] ?? ''),
                      const SizedBox(width: 4),
                      Text(category['name'] ?? ''),
                    ],
                  ),
                  selected: selectedCategory == category['name'],
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selectedCategory = category['name'];
                      } else {
                        selectedCategory = null;
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const Spacer(),
            SimpleButton(
              data: 'Next',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ExpenseCategoryPage(),
                    ));
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
