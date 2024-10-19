import 'package:flutter/material.dart';

import 'card_payment_screen.dart';
import 'ezcash_payment_screen.dart';

class PaymentMethodScreen extends StatelessWidget {
  final String accountNumber;
  final String amount;

  const PaymentMethodScreen(
      {super.key, required this.accountNumber, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Center(
          child: Text(
            'Select Payment Method',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Center(
        // Center the content
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Choose a Payment Method',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CardPaymentScreen(
                            accountNumber: accountNumber, amount: amount)),
                  );
                },
                icon: const Icon(Icons.credit_card), // Icon for card payment
                label: const Text('Pay with Card'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EzCashPaymentScreen(
                            accountNumber: accountNumber, amount: amount)),
                  );
                },
                icon: const Icon(Icons.money), // Icon for eZ Cash payment
                label: const Text('Pay with eZ Cash'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
