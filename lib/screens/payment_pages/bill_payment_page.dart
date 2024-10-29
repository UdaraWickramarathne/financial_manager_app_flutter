import 'package:financial_app/screens/payment_pages/types_of_bill/electricity_bill.dart';
import 'package:financial_app/screens/payment_pages/types_of_bill/internet_bill.dart';
import 'package:financial_app/screens/payment_pages/types_of_bill/mobile_bill.dart';
import 'package:financial_app/screens/payment_pages/types_of_bill/transport_bill.dart';
import 'package:financial_app/screens/payment_pages/types_of_bill/water_bill.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BillPayScreen(),
    );
  }
}

class BillPayScreen extends StatelessWidget {
  const BillPayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Center(
          child: Text(
            'Bill Payment',
            style: TextStyle(fontSize: 22),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          crossAxisCount: 2,
          children: [
            OptionCard(
              color: Colors.blue,
              icon: Icons.flash_on,
              title: 'Electricity',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ElectricityBillScreen(),
                  ),
                );
              },
            ),
            OptionCard(
              color: Colors.purple,
              icon: Icons.wifi,
              title: 'Internet',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InternetBillScreen(),
                  ),
                );
              },
            ),
            OptionCard(
              color: Colors.orangeAccent,
              icon: Icons.water,
              title: 'Water',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WaterBillScreen(),
                  ),
                );
              },
            ),
            OptionCard(
              color: Colors.green,
              icon: Icons.directions_bus,
              title: 'Transport',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TransportScreen(),
                  ),
                );
              },
            ),
            OptionCard(
              color: Colors.red,
              icon: Icons.phone_iphone,
              title: 'Mobile',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MobileBillScreen(),
                  ),
                );
              },
            ),
            OptionCard(
              color: Colors.grey,
              icon: Icons.tv,
              title: 'TV',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ElectricityBillScreen(),
                  ),
                );
              },
            ),
            OptionCard(
              color: Colors.teal,
              icon: Icons.shield,
              title: 'Insurance',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ElectricityBillScreen(),
                  ),
                );
              },
            ),
            OptionCard(
              color: Colors.cyan,
              icon: Icons.more_horiz,
              title: 'Other',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ElectricityBillScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const OptionCard(
      {super.key,
      required this.color,
      required this.icon,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
