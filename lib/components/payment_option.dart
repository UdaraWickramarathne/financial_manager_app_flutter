import 'package:flutter/material.dart';

class PaymentOption extends StatefulWidget {
  final bool isVisa;
  final String name;
  final String number;
  final bool isSelected;

  const PaymentOption({
    super.key,
    required this.isSelected,
    required this.name,
    required this.number,
    required this.isVisa,
  });

  @override
  State<PaymentOption> createState() => _PaymentOptionState();
}

class _PaymentOptionState extends State<PaymentOption> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            widget.isSelected ? Theme.of(context).colorScheme.surfaceDim : null,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          leading: Image.asset(
            widget.isVisa
                ? 'assets/payments/visa_edit.png'
                : 'assets/payments/master_edit.png',
            width: 80,
          ),
          title: Text(
            widget.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text('**** ${widget.number}'),
          ),
        ),
      ),
    );
  }
}
