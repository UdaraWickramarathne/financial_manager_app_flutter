import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../components/login_singup_button.dart';
import '../payment_methord/payment_methord_screen.dart';

class InternetBillScreen extends StatefulWidget {
  @override
  _InternetBillScreenState createState() => _InternetBillScreenState();
}

class _InternetBillScreenState extends State<InternetBillScreen> {
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

  final List<String> imagePaths = [
    'assets/a/images.png',
    'assets/a/images (4).jpg',
    'assets/a/images (3).jpg',
    'assets/a/download (8).jpg',
    'assets/a/download (7).jpg',
    'assets/a/images (1).png',
    'assets/a/7xFun-highlights.jpg',

  ];

  final List<String> billers = ['SLT Mobitel', 'Dialog Broadband', 'Lankabell'];

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
                    selectedBiller = biller;
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
        flexibleSpace: Container(
          alignment: Alignment.center,
          child: const Text(
            'Internet Bill Payment',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
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
                backgroundColor: Colors.purple,
                child: Icon(Icons.wifi, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 20),
              const Text(
                'Enter Your Payment Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              // Biller selection section
              GestureDetector(
                onTap: _showBillerSelectionDialog,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.cell_tower),
                          const SizedBox(width: 8),
                          Text(
                            selectedBiller ?? 'Select Biller',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 10),
              CarouselSlider(
                options: CarouselOptions(
                  height: 150.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: imagePaths.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      );
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}