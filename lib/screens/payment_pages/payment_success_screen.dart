import 'dart:typed_data';
import 'package:financial_app/components/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:screenshot/screenshot.dart';

class PaymentSuccessScreen extends StatefulWidget {
  final String accountNumber;
  final String amount;

  const PaymentSuccessScreen({
    super.key,
    required this.accountNumber,
    required this.amount,
  });

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  final ScreenshotController screenshotController = ScreenshotController();

  Future<void> saveImage(Uint8List bytes) async {
    String time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = 'screenshot_${time}';
    await Permission.storage.request();
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    debugPrint('result: $result');
  }

  void showBottomDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Screenshot(
          controller: screenshotController,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Mobile Bill',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    '1******6196',
                    style: TextStyle(
                      color: Color(0xFFA4A9AE),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                        color: const Color(0xFFddf8f0),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text.rich(
                      TextSpan(
                        text: 'Transaction Status: ', // Regular text
                        style: TextStyle(
                          color: Color(0xFF13c999),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Paid', // Bold text
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text.rich(
                    TextSpan(
                      text: 'Rs', // Regular text
                      style: TextStyle(fontSize: 30),
                      children: <TextSpan>[
                        TextSpan(
                          text: '5000.00', // Bold text
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Transaction ID:',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text('TXN123456789'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    color: Color(0xFFebf1f5),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text('2024/10/25'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    color: Color(0xFFebf1f5),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Time',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text('06:25 PM'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () async {
                      await screenshotController.capture().then(
                        (bytes) {
                          if (bytes != null) {
                            saveImage(bytes);
                          }
                        },
                      ).catchError(
                        (error) {
                          debugPrint(error);
                        },
                      );
                    },
                    child: const Text('Take Screenshot'),
                  ),
                ],
              ),
            ),
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
        title: const Center(
          child: Text(
            'Confirmation',
            style: TextStyle(fontSize: 22),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 15),
              const Text(
                'Payment Successful!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF456EFE),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              const Text(
                'Thank you! Your payment was processed successfully.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 80),
              Image.asset(
                'assets/images/success.png',
                width: 300,
              ),
              const Spacer(),
              TextButton(
                onPressed: () => showBottomDialog(context),
                child: const Text('View Receipt'),
              ),
              const SizedBox(
                height: 10,
              ),
              SimpleButton(
                data: 'Done',
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
