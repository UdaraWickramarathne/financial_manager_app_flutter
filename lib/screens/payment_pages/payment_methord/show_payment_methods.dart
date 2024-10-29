import 'package:financial_app/components/payment_option.dart';
import 'package:financial_app/components/simple_button.dart';
import 'package:flutter/material.dart';

class PaymentMethodSheet extends StatelessWidget {
  const PaymentMethodSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 550,
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Choose payment method',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    PaymentOption(
                      isSelected: true,
                      name: 'Udara Wick',
                      number: '1425',
                      isVisa: true,
                    ),
                    PaymentOption(
                      isSelected: false,
                      name: 'Sahan Dulmith',
                      number: '2635',
                      isVisa: false,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                TextButton(
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Icon(Icons.add),
                        SizedBox(width: 5),
                        Text(
                          'Add new card',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFe3f7ef),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        textAlign: TextAlign.justify,
                        'We adhere entirely to the data security standards of the payment card industry.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SimpleButton(
              data: 'Continue',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
