import 'package:flutter/material.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final String accountNumber;
  final String amount;

  const PaymentSuccessScreen({
    super.key,
    required this.accountNumber,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Success'),
        automaticallyImplyLeading: false, // Disable back button
      ),
      body: Center( // Use Center widget here
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle_outline, color: Colors.green, size: 100),
              const SizedBox(height: 30),
              const Text(
                'Payment Successful!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Account Number: $accountNumber',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              Text(
                'Amount Paid: \$$amount',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Navigate back to the bill screen or reset the flow
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Done'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
