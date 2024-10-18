import 'package:flutter/material.dart';

import '../../../components/login_singup_button.dart';
import '../payment_methord/payment_methord_screen.dart';

class DateSelection extends StatefulWidget {
  const DateSelection({super.key});

  @override
  _DateSelectionState createState() => _DateSelectionState();
}

class _DateSelectionState extends State<DateSelection> {
  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController paymentDateController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    paymentDateController.text = DateTime.now().toLocal().toString().split(' ')[0];
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        dueDateController.text = picked.toLocal().toString().split(' ')[0];
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
        paymentDateController.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Enter Your Payment Details',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 40),
        TextField(
          controller: accountNumberController,
          decoration: const InputDecoration(
            labelText: 'Account Number',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.account_circle),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
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
        TextField(
          controller: dueDateController,
          decoration: const InputDecoration(
            labelText: 'Due Date',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.calendar_today),
          ),
          readOnly: true,
          onTap: () => _selectDueDate(context),
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
        const SizedBox(height: 96),
        LoginSingupButton(
          data: 'Pay Bill',
          onPressed: () {
            if (accountNumberController.text.isNotEmpty &&
                amountController.text.isNotEmpty) {
              // Add your payment processing logic here
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentMethodScreen(
                    accountNumber: accountNumberController.text,
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
    );
  }
}
