import 'package:financial_app/components/input_field.dart';
import 'package:financial_app/language/transalation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ScanDetailsPage extends StatefulWidget {
  final String code;
  final Function() closeScreen;

  const ScanDetailsPage({
    super.key,
    required this.code,
    required this.closeScreen,
  });

  @override
  State<ScanDetailsPage> createState() => _QRResultState();
}

class _QRResultState extends State<ScanDetailsPage> {
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController contactInfoController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _parseQRCodeData(widget.code);
  }

  void _parseQRCodeData(String code) {
    // Split the QR code by ';' to get each key-value pair
    final List<String> pairs = code.split(';');

    for (var pair in pairs) {
      // Split each pair by ':' to separate the key and value
      final List<String> keyValue = pair.split(':');
      if (keyValue.length == 2) {
        final String key = keyValue[0].trim().toLowerCase();
        final String value = keyValue[1].trim();

        // Map the keys to their respective text fields
        if (key == 'shopname') {
          shopNameController.text = value;
        } else if (key == 'contactinfo') {
          contactInfoController.text = value;
        } else if (key == 'address') {
          addressController.text = value;
        } else if (key == 'amount') {
          amountController.text = value;
        }
      }
    }
  }

  @override
  void dispose() {
    shopNameController.dispose();
    contactInfoController.dispose();
    addressController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
          actions: [
            const Padding(
            padding: EdgeInsets.only(right: 30),
          ),
            IconButton(
              onPressed: () {
                    width:MediaQuery.of(context).size.width - 150;
                    height:60;
                Clipboard.setData(ClipboardData(text: widget.code));
                ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Copied to clipboard")),
                );
              },
              icon: const Icon(Icons.copy),
            ),
          ],
        centerTitle: true,
        title: const Center(
          child: Text(
            'Pay',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 2),
              QrImageView(
                data: widget.code,
                size: 300,
                version: QrVersions.auto,
              ),
              const SizedBox(height: 20),
              const Text(
                "Scanned QR",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              /*const SizedBox(height: 10),
              Text(
                widget.code,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                ),
              ),*/
              const SizedBox(height: 20),
              InputField(
                      isObsecure: false,
                      controller: shopNameController,
                      isReadOnly: true,
                      prefixIcon: Icons.maps_home_work_outlined,
                      label: 'Shop Name',
                    ),
              const SizedBox(height: 20),
              InputField(
                      isObsecure: false,
                      controller: contactInfoController,
                      isReadOnly: true,
                      prefixIcon: Icons.call_outlined,
                      keyboardType: TextInputType.number,
                      label: 'Contact Info',
                    ),
              const SizedBox(height: 20),
              InputField(
                      isObsecure: false,
                      controller: addressController,
                      isReadOnly: true,
                      prefixIcon: Icons.location_on_outlined,
                      label: 'Address',
                    ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  print("Shop Name: ${shopNameController.text}");
                  print("Contact Info: ${contactInfoController.text}");
                  print("Address: ${addressController.text}");
                  print("Amount: ${amountController.text}");
                },
                child: const Text(
                  "PAY NOW",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
