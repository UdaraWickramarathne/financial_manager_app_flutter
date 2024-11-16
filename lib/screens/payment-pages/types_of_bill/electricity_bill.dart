import 'package:financial_app/components/input_field.dart';
import 'package:financial_app/components/simple_button.dart';

import 'package:financial_app/screens/payment-pages/payment_methord/show_payment_methods.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ElectricityBillScreen extends StatefulWidget {
  const ElectricityBillScreen({super.key});

  @override
  State<ElectricityBillScreen> createState() => _ElectricityBillScreenState();
}

class _ElectricityBillScreenState extends State<ElectricityBillScreen> {
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
            'Electricity Bill Payment',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.blue,
                      child:
                          Icon(Icons.flash_on, size: 50, color: Colors.white),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Enter Your Payment Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
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
                      label: 'Amount',
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
                  ],
                ),
              ),
            ),
            SimpleButton(
              data: 'Pay Bill',
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => const PaymentMethodSheet(),
                );
                // if (accountNumberController.text.isNotEmpty &&
                //     amountController.text.isNotEmpty) {
                //   // Add your payment processing logic here
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => PaymentMethodScreen(
                //         accountNumber: accountNumberController.text,
                //         amount: amountController.text,
                //       ),
                //     ),
                //   );
                // } else {
                //   showDialog(
                //     context: context,
                //     builder: (context) => AlertDialog(
                //       title: const Text('Error'),
                //       content: const Text('Please fill in all fields'),
                //       actions: [
                //         TextButton(
                //           onPressed: () => Navigator.pop(context),
                //           child: const Text('OK'),
                //         ),
                //       ],
                //     ),
                //   );
                // }
              },
            ),
          ],
        ),
      ),
    );
  }
}
