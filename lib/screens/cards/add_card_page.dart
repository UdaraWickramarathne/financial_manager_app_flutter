import 'package:financial_app/components/input_field.dart';
import 'package:financial_app/components/simple_button.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final _cardNumberController = TextEditingController();
  final _dateController = TextEditingController();
  final _cvvController = TextEditingController();
  final _nameController = TextEditingController();
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  final FlipCardController _cardController = FlipCardController();

  void _flipCard() {
    cardKey.currentState!.toggleCard();
  }

  void _flipBackward() {
    if (!_cardController.state!.isFront) {
      cardKey.currentState!.toggleCard();
    }
  }

  Stack _buildCardBackView() {
    return Stack(
      children: [
        Image.asset(
          'assets/images/card_back.png',
          height: 230,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 130),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Text(
                        _cvvController.text.isEmpty
                            ? '___'
                            : _cvvController.text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        'CVV',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Stack _buildFrontView() {
    return Stack(
      children: [
        Image.asset(
          'assets/images/card.png',
          height: 230,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 130),
              Text(
                _cardNumberController.text.isEmpty
                    ? '____  ____  ____ ____'
                    : _cardNumberController.text,
                style: const TextStyle(
                    color: Colors.white, fontSize: 16, letterSpacing: 3),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _nameController.text.isEmpty
                        ? '______ _____'
                        : _nameController.text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    _dateController.text.isEmpty
                        ? '__ /__'
                        : _dateController.text,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Center(
          child: Text(
            'Add your Card',
            style: TextStyle(fontSize: 22),
          ),
        ),
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
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FlipCard(
                      controller: _cardController,
                      key: cardKey,
                      front: _buildFrontView(),
                      back: _buildCardBackView(),
                    ),
                    const SizedBox(height: 50),
                    InputField(
                      isObsecure: false,
                      controller: _nameController,
                      isReadOnly: false,
                      label: 'Card Holder Name',
                      onChanged: (p0) => setState(() {}),
                      inputFormat: [
                        LengthLimitingTextInputFormatter(16),
                      ],
                      onTap: _flipBackward,
                    ),
                    const SizedBox(height: 20),
                    InputField(
                      isObsecure: false,
                      controller: _cardNumberController,
                      isReadOnly: false,
                      label: 'Card Number',
                      onChanged: (p0) => setState(() {}),
                      onTap: _flipBackward,
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
                            controller: _dateController,
                            isReadOnly: false,
                            onChanged: (p0) => setState(() {}),
                            label: 'Expire Date',
                            onTap: _flipBackward,
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
                            controller: _cvvController,
                            isReadOnly: false,
                            onChanged: (p0) => setState(() {}),
                            keyboardType: TextInputType.number,
                            label: 'CVV',
                            inputFormat: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                            onTap: _flipCard,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SimpleButton(
              data: 'Save Card',
              onPressed: () {},
            )
          ],
        ),
      ),
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
