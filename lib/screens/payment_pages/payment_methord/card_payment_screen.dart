import 'package:financial_app/components/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../payment_success_screen.dart';

class CardPaymentScreen extends StatefulWidget {
  final String accountNumber;
  final String amount;

  const CardPaymentScreen(
      {super.key, required this.accountNumber, required this.amount});

  @override
  _CardPaymentScreenState createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  String? selectedCardType = '';
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  late Timer _timer;
  int _start = 90;
  bool saveCard = false;

  @override
  void initState() {
    super.initState();
    startTimer();
    cardNumberController.addListener(_updateCardType);
  }

  void _updateCardType() {
    String cardNumber = cardNumberController.text.replaceAll(RegExp(r'\D'), '');
    if (cardNumber.isNotEmpty) {
      if (cardNumber.startsWith('4')) {
        setState(() {
          selectedCardType = 'Visa';
        });
      } else if (cardNumber.startsWith('5')) {
        setState(() {
          selectedCardType = 'MasterCard';
        });
      } else {
        setState(() {
          selectedCardType = null;
        });
      }
    } else {
      setState(() {
        selectedCardType = null;
      });
    }
  }

  void saveCardDetails(String cardNumber, String expiryDate, String cvv) {
    // Add logging for debugging purposes
    print('Card details saved: $cardNumber, $expiryDate, $cvv');
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        _timer.cancel();
        Navigator.of(context).pop();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  String getTimerText() {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  bool _isExpiryDateValid(String expiryDate) {
    if (expiryDate.length != 5 ||
        !RegExp(r'^\d{2}/\d{2}$').hasMatch(expiryDate)) {
      return false;
    }

    // Extract month and year
    final parts = expiryDate.split('/');
    final month = int.parse(parts[0]);
    final year = int.parse(parts[1]) + 2000;

    // Get the current date
    final now = DateTime.now();
    final currentYear = now.year;
    final currentMonth = now.month;

    if (month < 1 || month > 12) {
      return false;
    }
    if (year < now.year || year > 2032) {
      return false;
    }

    return (year > currentYear) ||
        (year == currentYear && month >= currentMonth);
  }

  void _onContinuePressed() {
    if (cardNumberController.text.isEmpty ||
        expiryDateController.text.isEmpty ||
        cvvController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all card details before continuing.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    if (cardNumberController.text.replaceAll(RegExp(r'\D'), '').length != 16) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Card number must be 16 digits.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    if (!_isExpiryDateValid(expiryDateController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Expiry date must be in MM/YY format and valid.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    if (cvvController.text.replaceAll(RegExp(r'\D'), '').length != 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('CVV must be 3 digits.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Save Card'),
          content: const Text('Do you want to save this card?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentSuccessScreen(
                      accountNumber: widget.accountNumber,
                      amount: widget.amount,
                    ),
                  ),
                );
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                saveCardDetails(cardNumberController.text,
                    expiryDateController.text, cvvController.text);
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentSuccessScreen(
                      accountNumber: widget.accountNumber,
                      amount: widget.amount,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    cardNumberController
        .removeListener(_updateCardType); // Remove listener on dispose
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Payment'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildAmountDisplay(),
            const SizedBox(height: 26),
            const Text(
              'Enter Card Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 16),
                      _buildCardTypeSelection(),
                      const SizedBox(height: 20),
                      _buildTextField(
                          'Card Number', cardNumberController, Colors.orange,
                          isCardNumber: true),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                              child: _buildTextField('Expiry Date',
                                  expiryDateController, Colors.green,
                                  isExpiryDate: true)),
                          const SizedBox(width: 16),
                          Expanded(
                              child: _buildTextField(
                                  'CVV', cvvController, Colors.red)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Checkbox(
                            value: saveCard,
                            onChanged: (value) {
                              setState(() {
                                saveCard = value ?? false;
                                if (saveCard) {
                                  saveCardDetails(
                                      cardNumberController.text,
                                      expiryDateController.text,
                                      cvvController.text);
                                }
                              });
                            },
                          ),
                          const Text('Save Card Details'),
                        ],
                      ),
                      const SizedBox(height: 26),
                      SimpleButton(
                        data: 'Continue',
                        onPressed:
                            _onContinuePressed, // Update to use the validation method
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Time left: ${getTimerText()}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardTypeSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCardRadio('Visa'),
        const SizedBox(width: 20),
        _buildCardRadio('MasterCard'),
      ],
    );
  }

  Widget _buildCardRadio(String cardType) {
    return Row(
      children: [
        Radio<String>(
          value: cardType,
          groupValue: selectedCardType,
          onChanged: (value) {
            setState(() {
              selectedCardType = value;
            });
          },
        ),
        Text(cardType),
      ],
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, Color borderColor,
      {bool isCardNumber = false,
      bool isExpiryDate = false,
      bool isCVV = false}) {
    return TextField(
      controller: controller,
      keyboardType: isCardNumber || isExpiryDate || isCVV
          ? TextInputType.number
          : TextInputType.number,
      inputFormatters: isCardNumber
          ? [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
              CardNumberInputFormatter(),
            ]
          : isExpiryDate
              ? [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                  ExpiryDateInputFormatter(),
                ]
              : isCVV
                  ? [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ]
                  : [],
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: borderColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      ),
    );
  }

  Widget _buildAmountDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Amount: ',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.lightBlueAccent),
        ),
        Text(
          '\$${widget.amount}',
          style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.lightBlueAccent),
        ),
      ],
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'\D'), '');
    String formattedText = '';
    for (int i = 0; i < newText.length; i++) {
      if (i % 4 == 0 && i != 0) formattedText += ' ';
      formattedText += newText[i];
    }
    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'\D'), '');
    String formattedText = '';
    if (newText.length > 2) {
      formattedText =
          '${newText.substring(0, 2)}/${newText.substring(2, newText.length)}';
    } else {
      formattedText = newText;
    }
    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
