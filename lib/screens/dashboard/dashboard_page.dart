import 'package:financial_app/components/dropdown_button.dart';
import 'package:financial_app/components/reminder_card.dart';
import 'package:financial_app/components/services_icon.dart';
import 'package:financial_app/components/transaction_tile.dart';
import 'package:financial_app/components/visa_card.dart';
import 'package:financial_app/models/transaction.dart';
import 'package:financial_app/screens/analysis/analysis_page.dart';
import 'package:financial_app/screens/budget/budget_page.dart';
import 'package:financial_app/screens/goals/goal_page.dart';
import 'package:financial_app/screens/notification/notification_page.dart';
import 'package:financial_app/screens/reminder/reminder_page.dart';
import 'package:financial_app/screens/transactions/transactions_page.dart';
import 'package:financial_app/services/custom_route.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: const Icon(
                Icons.notifications,
              ),
              onPressed: () {
                Navigator.of(context).push(CustomPageRoute(
                  page: const NotificationPage(),
                ));
              },
            ),
          ),
        ],
        centerTitle: true,
        title: const Center(
          child: Text(
            'Dashboard',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const VisaCard(),
            const SizedBox(height: 20),
            const Row(
              children: [
                Text(
                  "Services",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ServicesIcon(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const TransactionsPage(),
                            ));
                          },
                          backgroundColor: Colors.blue[100],
                          text: 'Transcations',
                          icon: Icons.monetization_on_outlined,
                          foregroundColor: Colors.blue,
                        ),
                        const SizedBox(width: 10),
                        ServicesIcon(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const AnalysisPage(),
                            ));
                          },
                          backgroundColor:
                              const Color.fromARGB(255, 251, 187, 251),
                          text: 'Reports',
                          icon: Icons.file_copy_outlined,
                          foregroundColor:
                              const Color.fromARGB(255, 255, 98, 255),
                        ),
                        const SizedBox(width: 10),
                        ServicesIcon(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ReminderPage(),
                            ));
                          },
                          backgroundColor:
                              const Color.fromARGB(255, 251, 218, 187),
                          text: 'Reminders',
                          icon: Icons.alarm,
                          foregroundColor:
                              const Color.fromARGB(255, 253, 159, 71),
                        ),
                        const SizedBox(width: 10),
                        ServicesIcon(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const GoalPage(),
                            ));
                          },
                          backgroundColor:
                              const Color.fromARGB(255, 187, 251, 190),
                          text: 'Goals',
                          icon: Icons.stairs_outlined,
                          foregroundColor:
                              const Color.fromARGB(255, 56, 250, 66),
                        ),
                        const SizedBox(width: 10),
                        ServicesIcon(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const BudgetPage(),
                            ));
                          },
                          backgroundColor:
                              const Color.fromARGB(255, 246, 187, 251),
                          text: 'Budget',
                          icon: Icons.account_balance_wallet,
                          foregroundColor:
                              const Color.fromARGB(255, 146, 56, 250),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent History",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ChoiceBox(),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return TransactionTile(
                    boxColor: transaction.boxColor,
                    icon: transaction.icon,
                    iconColor: transaction.iconColor,
                    title: transaction.title,
                    description: transaction.description,
                    price: transaction.price,
                    date: transaction.date,
                    isIncome: transaction.isIncome,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
