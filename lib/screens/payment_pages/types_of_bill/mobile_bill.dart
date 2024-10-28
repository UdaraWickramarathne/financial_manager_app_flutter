import 'package:financial_app/components/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../components/clickble_textfield.dart';
import '../../../components/input_field.dart';
import '../payment_methord/payment_methord_screen.dart';

class MobileBillScreen extends StatefulWidget {
  const MobileBillScreen({super.key});

  @override
  State<MobileBillScreen> createState() => _MobileBillScreenState();
}

class _MobileBillScreenState extends State<MobileBillScreen> {
  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController selectBillerController = TextEditingController();
  final TextEditingController paymentDateController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

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
                      _isBillerSelected = true;
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
            'Mobile Bill Payment',
            style: TextStyle(fontSize: 20),
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
              backgroundColor: Colors.red,
              child: Icon(Icons.phone_android, size: 50, color: Colors.white),
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
            InputField(
              isObsecure: false,
              controller: accountNumberController,
              isReadOnly: false,
              prefixIcon: Icons.mobile_friendly,
              keyboardType: TextInputType.number,
              label: 'Mobile Number',
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
            if (_isPostpaidSelected) ...[
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
            ],
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
