import 'package:financial_app/components/dropdown_button.dart';
import 'package:financial_app/components/services_icon.dart';
import 'package:financial_app/components/transaction_tile.dart';
import 'package:financial_app/components/visa_card.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

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
            'Home',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const VisaCard(),
            const SizedBox(height: 30),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Services",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'See All',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ServicesIcon(
                  backgroundColor: Colors.blue[100],
                  text: 'Transcations',
                  icon: Icons.monetization_on_outlined,
                  foregroundColor: Colors.blue,
                ),
                const ServicesIcon(
                    backgroundColor: Color.fromARGB(255, 251, 187, 251),
                    text: 'Report',
                    icon: Icons.file_copy_outlined,
                    foregroundColor: Color.fromARGB(255, 255, 98, 255)),
                const ServicesIcon(
                  backgroundColor: Color.fromARGB(255, 251, 218, 187),
                  text: 'Reminders',
                  icon: Icons.alarm,
                  foregroundColor: Color.fromARGB(255, 253, 159, 71),
                ),
                const ServicesIcon(
                  backgroundColor: Color.fromARGB(255, 187, 251, 190),
                  text: 'Goals',
                  icon: Icons.stairs_outlined,
                  foregroundColor: Color.fromARGB(255, 56, 250, 66),
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
                ChoiceBox()
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TransactionTile(
                      boxColor: Colors.yellow.shade200,
                      icon: Icons.electric_bolt_rounded,
                      iconColor: Colors.yellow.shade900,
                      title: 'Bill Pay',
                      description: 'Electric Bill',
                      price: '100',
                      date: '04 June',
                      isIncome: false,
                    ),
                    TransactionTile(
                      boxColor: Colors.yellow.shade200,
                      icon: Icons.electric_bolt_rounded,
                      iconColor: Colors.yellow.shade900,
                      title: 'Income',
                      description: 'Electric Bill',
                      price: '100',
                      date: '04 June',
                      isIncome: false,
                    ),
                    TransactionTile(
                      boxColor: Colors.yellow.shade200,
                      icon: Icons.electric_bolt_rounded,
                      iconColor: Colors.yellow.shade900,
                      title: 'Bill Pay',
                      description: 'Electric Bill',
                      price: '100',
                      date: '04 June',
                      isIncome: false,
                    ),
                    TransactionTile(
                      boxColor: Colors.yellow.shade200,
                      icon: Icons.electric_bolt_rounded,
                      iconColor: Colors.yellow.shade900,
                      title: 'Bill Pay',
                      description: 'Electric Bill',
                      price: '100',
                      date: '04 June',
                      isIncome: false,
                    ),
                    TransactionTile(
                      boxColor: Colors.yellow.shade200,
                      icon: Icons.electric_bolt_rounded,
                      iconColor: Colors.yellow.shade900,
                      title: 'Bill Pay',
                      description: 'Electric Bill',
                      price: '100',
                      date: '04 June',
                      isIncome: false,
                    ),
                    TransactionTile(
                      boxColor: Colors.yellow.shade200,
                      icon: Icons.electric_bolt_rounded,
                      iconColor: Colors.yellow.shade900,
                      title: 'Bill Pay',
                      description: 'Electric Bill',
                      price: '100',
                      date: '04 June',
                      isIncome: false,
                    )
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
