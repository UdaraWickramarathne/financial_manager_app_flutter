import 'package:financial_app/components/budget_card.dart';
import 'package:financial_app/components/balance_card.dart';
import 'package:flutter/material.dart';
import 'budget_add.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 30),
          ),
        ],
        centerTitle: true,
        title: const Center(
          child: Text(
            'Your Budgets',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            const BalanaceCard(),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create a budget',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Save more by setting a budget',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.surfaceDim,
                        ),
                        padding:
                            const WidgetStatePropertyAll(EdgeInsets.all(13))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BudgetAdd(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Row(
              children: [
                Text(
                  'My Budgets',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BudgetCard(
                      id: '1',
                      title: 'Groceries',
                      budgetAmount: 60000,
                      spendAmount: 2000,
                      icon: Icons.shopping_cart,
                    ),
                    BudgetCard(
                      id: '1',
                      title: 'Travels',
                      budgetAmount: 60000,
                      spendAmount: 2000,
                      icon: Icons.directions_car,
                    ),
                    BudgetCard(
                      id: '1',
                      title: 'Entertainment',
                      budgetAmount: 60000,
                      spendAmount: 2000,
                      icon: Icons.theaters,
                    ),
                    BudgetCard(
                      id: '1',
                      title: 'Rent',
                      budgetAmount: 60000,
                      spendAmount: 2000,
                      icon: Icons.directions_car,
                    ),
                    BudgetCard(
                      id: '1',
                      title: 'Groceries',
                      budgetAmount: 60000,
                      spendAmount: 2000,
                      icon: Icons.shopping_cart,
                    ),
                    BudgetCard(
                      id: '1',
                      title: 'Groceries',
                      budgetAmount: 60000,
                      spendAmount: 2000,
                      icon: Icons.shopping_cart,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
