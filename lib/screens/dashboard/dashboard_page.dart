import 'package:financial_app/components/dropdown_button.dart';
import 'package:financial_app/components/services_icon.dart';
import 'package:financial_app/components/transaction_tile.dart';
import 'package:financial_app/components/visa_card.dart';
import 'package:financial_app/models/transaction.dart';
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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: Icon(Icons.notifications),
          ),
        ],
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
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Services",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    'See All',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ServicesIcon(
                          onPressed: () {},
                          backgroundColor: Colors.blue[100],
                          text: 'Transcations',
                          icon: Icons.monetization_on_outlined,
                          foregroundColor: Colors.blue,
                        ),
                        const SizedBox(width: 10),
                        ServicesIcon(
                          onPressed: () {},
                          backgroundColor:
                              const Color.fromARGB(255, 251, 187, 251),
                          text: 'Reports',
                          icon: Icons.file_copy_outlined,
                          foregroundColor:
                              const Color.fromARGB(255, 255, 98, 255),
                        ),
                        const SizedBox(width: 10),
                        ServicesIcon(
                          onPressed: () {},
                          backgroundColor:
                              const Color.fromARGB(255, 251, 218, 187),
                          text: 'Reminders',
                          icon: Icons.alarm,
                          foregroundColor:
                              const Color.fromARGB(255, 253, 159, 71),
                        ),
                        const SizedBox(width: 10),
                        ServicesIcon(
                          onPressed: () {},
                          backgroundColor:
                              const Color.fromARGB(255, 187, 251, 190),
                          text: 'Goals',
                          icon: Icons.stairs_outlined,
                          foregroundColor:
                              const Color.fromARGB(255, 56, 250, 66),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
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
                itemCount: transactions.length,
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
