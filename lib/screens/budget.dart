import 'package:flutter/material.dart';

class BudgetPlansHome extends StatelessWidget {
  const BudgetPlansHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Budget Plans"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Total Budget Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Budget: \$2000",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                SizedBox(height: 8),
                Text(
                  "Spent: \$1200",
                  style: TextStyle(fontSize: 18, color: Colors.white70),
                ),
                SizedBox(height: 16),
                LinearProgressIndicator(
                  value: 1200 / 2000, // Example Progress
                  backgroundColor: Colors.white54,
                  color: Colors.greenAccent,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Budget Categories List
          const BudgetCategoryCard(category: "Food", limit: 500, spent: 400),
          const BudgetCategoryCard(
              category: "Transport", limit: 200, spent: 100),
          const BudgetCategoryCard(
              category: "Entertainment", limit: 300, spent: 250),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add Budget Page
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Budget Category Card
class BudgetCategoryCard extends StatelessWidget {
  final String category;
  final double limit;
  final double spent;

  const BudgetCategoryCard({
    super.key,
    required this.category,
    required this.limit,
    required this.spent,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Limit: \$${limit.toStringAsFixed(2)}"),
            Text("Spent: \$${spent.toStringAsFixed(2)}"),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: spent / limit,
              backgroundColor: Colors.grey[300],
              color: spent > limit ? Colors.red : Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
