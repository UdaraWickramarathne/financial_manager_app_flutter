import 'package:financial_app/components/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../components/clickble_textfield.dart';
import '../../../components/input_field.dart';

class InternetBillScreen extends StatefulWidget {
  const InternetBillScreen({super.key});

  @override
  _InternetBillScreenState createState() => _InternetBillScreenState();
}

class _InternetBillScreenState extends State<InternetBillScreen> {
  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController selectBillerController = TextEditingController();
  final TextEditingController paymentDateController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    paymentDateController.text =
        DateTime.now().toLocal().toString().split(' ')[0];
  }

  final List<String> billers = ['Peo TV', 'Dialog TV'];

  String? selectedBiller;

  void _showBillerSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Biller'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: billers.map((biller) {
              return ListTile(
                title: Text(biller),
                onTap: () {
                  setState(() {
                    selectBillerController.text = biller;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
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
            'Internet Bill Payment',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                child: Icon(Icons.tv, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 20),
              const Text(
                'Enter Your Payment Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              ClickbleTextfield(
                prefixIcon: Icons.cell_tower,
                controller: selectBillerController,
                label: 'Select Biller',
                onTap: () => _showBillerSelectionDialog(),
              ),
              const SizedBox(height: 16),
              InputField(
                isObsecure: false,
                controller: accountNumberController,
                isReadOnly: false,
                prefixIcon: Icons.tv,
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
                label: 'Date of Payment',
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
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
