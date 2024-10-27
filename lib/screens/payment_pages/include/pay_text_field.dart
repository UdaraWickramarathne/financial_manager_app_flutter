import 'package:financial_app/components/input_field.dart';
import 'package:financial_app/components/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    paymentDateController.text =
        DateTime.now().toLocal().toString().split(' ')[0];
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
        InputField(
          isObsecure: false,
          controller: accountNumberController,
          isReadOnly: false,
          prefixIcon: Icons.account_circle,
          keyboardType: TextInputType.number,
          label: 'Account Number',
        ),
        const SizedBox(height: 16),
        InputField(
          isReadOnly: false,
          isObsecure: false,
          prefixIcon: Icons.money,
          label: '0.00',
          suffixIcon: TextButton(
            onPressed: () {
              amountController.text = '';
            },
            child: const Text('Clear'),
          ),
          prefixText: 'Rs.',
          controller: amountController,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        InputField(
          isReadOnly: true,
          isObsecure: false,
          label: 'Due Date',
          prefixIcon: Icons.date_range,
          suffixIcon: IconButton(
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );

              if (pickedDate != null) {
                dueDateController.text =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
              }
            },
            icon: const Icon(Icons.edit),
          ),
          controller: dueDateController,
        ),
        const SizedBox(height: 16),
        InputField(
          isReadOnly: true,
          isObsecure: false,
          prefixIcon: Icons.date_range,
          suffixIcon: IconButton(
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );

              if (pickedDate != null) {
                paymentDateController.text =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
              }
            },
            icon: const Icon(Icons.edit),
          ),
          controller: paymentDateController,
        ),
        const SizedBox(height: 96),
        SimpleButton(
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
