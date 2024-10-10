import 'package:financial_app/components/login_singup_button.dart';
import 'package:flutter/material.dart';

class IncomeCategoryPage extends StatefulWidget {
  const IncomeCategoryPage({super.key});

  @override
  State<IncomeCategoryPage> createState() => _IncomeCategoryPageState();
}

class _IncomeCategoryPageState extends State<IncomeCategoryPage> {
  String? selectedCategory;

  final List<Map<String, String>> incomeCategories = [
    {'name': 'Salary', 'icon': '💼'},
    {'name': 'Business', 'icon': '🏢'},
    {'name': 'Investment', 'icon': '📈'},
    {'name': 'Freelance', 'icon': '💻'},
    {'name': 'Gift', 'icon': '🎁'},
    {'name': 'Other', 'icon': '🔍'},
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
              children: incomeCategories.map((category) {
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
              onPressed: () {},
              color: Colors.green,
            ),
            const SizedBox(height: 40)
          ],
        ),
      ),
    );
  }
}
