import 'package:financial_app/components/input_field.dart';
import 'package:financial_app/components/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../payment_success_screen.dart';

class CardPaymentScreen extends StatefulWidget {
  final String accountNumber;
  final String amount;

  const CardPaymentScreen(
      {super.key, required this.accountNumber, required this.amount});

  @override
  State<CardPaymentScreen> createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  String? selectedCardType = '';
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  bool saveCard = false;

  @override
  void initState() {
    super.initState();

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
        scrolledUnderElevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: ImageIcon(
              AssetImage('assets/icons/scan.ico'),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
          bottom: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter Card Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 10,
                    right: 10,
                    left: 10,
                    bottom: 30,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.surfaceDim,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      _buildCardTypeSelection(),
                      const SizedBox(height: 16),
                      InputField(
                        isObsecure: false,
                        controller: nameController,
                        isReadOnly: false,
                        label: 'Card Holder Name',
                        inputFormat: [
                          LengthLimitingTextInputFormatter(16),
                        ],
                      ),
                      const SizedBox(height: 20),
                      InputField(
                        isObsecure: false,
                        controller: cardNumberController,
                        isReadOnly: false,
                        label: 'Card Number',
                        keyboardType: TextInputType.number,
                        inputFormat: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(16),
                          CardNumberInputFormatter(),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: InputField(
                              isObsecure: false,
                              controller: expiryDateController,
                              isReadOnly: false,
                              label: 'Expire Date',
                              keyboardType: TextInputType.number,
                              inputFormat: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                                ExpiryDateInputFormatter(),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: InputField(
                              isObsecure: false,
                              controller: cvvController,
                              isReadOnly: false,
                              keyboardType: TextInputType.number,
                              label: 'CVV',
                              inputFormat: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(3),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 30),
                      _buildAmountDisplay(),
                    ],
                  ),
                ),
              ),
            ),
            SimpleButton(
              data: 'Pay Now',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCardTypeSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
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

  Widget _buildAmountDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Amount: ',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        Text(
          '\$${widget.amount}',
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
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
