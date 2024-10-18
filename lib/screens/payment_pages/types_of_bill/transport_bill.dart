import 'package:financial_app/components/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../payment_methord/payment_methord_screen.dart'; // For date formatting

class TransportScreen extends StatefulWidget {
  const TransportScreen({super.key});

  @override
  _TransportScreenState createState() => _TransportScreenState();
}

class _TransportScreenState extends State<TransportScreen> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController travelDateController = TextEditingController();
  final TextEditingController paymentDateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  bool _isPaymentDateEditable = false;

  @override
  void initState() {
    super.initState();
    // Set the payment date to the current date
    paymentDateController.text =
        DateFormat('MM/dd/yyyy').format(DateTime.now());
  }

  Future<void> _selectTravelDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        travelDateController.text = DateFormat('MM/dd/yyyy').format(picked);
      });
    }
  }

  Future<void> _selectPaymentDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        paymentDateController.text = DateFormat('MM/dd/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        flexibleSpace: Container(
          alignment: Alignment.center,
          child: const Text(
            'Transport Payment',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.green,
              child: Icon(Icons.directions_bus, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              'Enter Your Transport Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // Input field for "From" location
            TextField(
              controller: fromController,
              decoration: const InputDecoration(
                labelText: 'From',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16),

            // Input field for "To" location
            TextField(
              controller: toController,
              decoration: const InputDecoration(
                labelText: 'To',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16),

            // Input field for amount
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.money),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // Travel Date
            TextField(
              controller: travelDateController,
              decoration: const InputDecoration(
                labelText: 'Travel Date',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () => _selectTravelDate(context),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: paymentDateController,
              decoration: InputDecoration(
                labelText: 'Date of Payment',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.calendar_today),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _selectPaymentDate(context),
                ),
              ),
              readOnly: true,
            ),
            const SizedBox(height: 16),
            SimpleButton(
              data: 'Pay Bill',
              onPressed: () {
                if (fromController.text.isNotEmpty &&
                    toController.text.isNotEmpty &&
                    amountController.text.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentMethodScreen(
                        accountNumber: fromController.text,
                        amount: amountController.text,
                      ),
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Error'),
                      content: const Text('Please fill in all fields'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
