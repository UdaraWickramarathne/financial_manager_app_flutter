import 'package:financial_app/components/simple_button.dart';
import 'package:flutter/material.dart';
import '../payment_methord/payment_methord_screen.dart';

class MobileBillScreen extends StatefulWidget {
  const MobileBillScreen({super.key});

  @override
  State<MobileBillScreen> createState() => _MobileBillScreenState();
}

class _MobileBillScreenState extends State<MobileBillScreen> {
  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController paymentDateController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  // Checkbox states
  bool _isPostpaidSelected = false;
  bool _isPrepaidSelected = false;
  bool _isBillerSelected = false;
  String? selectedBiller;

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

  final List<String> billers = ['SLT Mobitel', 'Dialog', 'Airtel'];

  void _showBillerSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Biller'),
          content: SingleChildScrollView(
            child: ListBody(
              children: billers.map((biller) {
                return ListTile(
                  title: Text(biller),
                  onTap: () {
                    setState(() {
                      selectedBiller = biller;
                      _isBillerSelected = true; // Update biller selection state
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  // Method to validate inputs
  bool _validateInputs() {
    bool isValid = true;

    // Check for mobile number validity
    if (accountNumberController.text.isEmpty ||
        !_validateMobileNumber(accountNumberController.text)) {
      isValid = false;
      _showErrorDialog('Please enter a valid mobile number.');
    }

    // Check for amount validity
    if (amountController.text.isEmpty) {
      isValid = false;
      _showErrorDialog('Please enter the amount.');
    }

    // Check for biller selection
    if (!_isBillerSelected) {
      isValid = false;
      _showErrorDialog('Please select a biller.');
    }

    // Check for payment type selection
    if (!_isPostpaidSelected && !_isPrepaidSelected) {
      isValid = false;
      _showErrorDialog('Please select either Postpaid or Prepaid.');
    }

    return isValid;
  }

  // Method to validate mobile number
  bool _validateMobileNumber(String number) {
    return number.startsWith('07') && number.length == 10;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mobile Bill Payment',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Icon(Icons.phone_android, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              'Enter Your Payment Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: _isPostpaidSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      _isPostpaidSelected = true;
                      _isPrepaidSelected = false;
                    });
                  },
                ),
                const Text('Postpaid'),
                const SizedBox(width: 20),
                Checkbox(
                  value: _isPrepaidSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      _isPrepaidSelected = true;
                      _isPostpaidSelected = false;
                    });
                  },
                ),
                const Text('Prepaid'),
              ],
            ),
            const SizedBox(height: 16),

            // Mobile number input with validation
            TextField(
              controller: accountNumberController,
              maxLength: 10, // Limit to 10 digits
              decoration: InputDecoration(
                labelText: 'Mobile Number',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.phone),
                errorText: _validateMobileNumber(accountNumberController.text)
                    ? null
                    : 'Invalid number',
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
            if (_isPostpaidSelected) ...[
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
            ],
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
            SimpleButton(
              data: 'Pay Bill',
              onPressed: () {
                // Validate all inputs
                if (_validateInputs()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentMethodScreen(
                        accountNumber: accountNumberController.text,
                        amount: amountController.text,
                      ),
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
