import 'package:financial_app/screens/payment_pages/include/pay_text_field.dart';
import 'package:flutter/material.dart';


class WaterBillScreen extends StatefulWidget {
  const WaterBillScreen({super.key});

  @override
  _WaterBillScreenState createState() => _WaterBillScreenState();
}

class _WaterBillScreenState extends State<WaterBillScreen> {

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
            'Water Bill Payment',
            style: TextStyle(fontSize: 20),
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
              backgroundColor: Colors.orangeAccent,
              child: Icon(Icons.water, size: 50, color: Colors.white),
            ),
            SizedBox(height: 20),
            DateSelection(),
          ],
        ),
      ),
    );
  }
}
