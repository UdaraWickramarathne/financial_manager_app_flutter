import 'package:financial_app/screens/payment_pages/include/pay_text_field.dart';
import 'package:flutter/material.dart';

class ElectricityBillScreen extends StatelessWidget {
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  ElectricityBillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Center(
          child: Text(
            'Electricity Bill',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 40),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Icon(Icons.flash_on, size: 50, color: Colors.white),
            ),
            SizedBox(height: 20),
            DateSelection(),
          ],
        ),
      ),
    );
  }
}
