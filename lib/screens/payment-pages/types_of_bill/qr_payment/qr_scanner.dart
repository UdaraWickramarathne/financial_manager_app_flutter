import 'package:financial_app/screens/payment-pages/types_of_bill/qr_payment/scan_datails_page.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool isFlashOn = false;
  bool isFrontCamera = false;
  bool isScanCompleted = false;
  MobileScannerController cameraController = MobileScannerController();

  void closeScreen() {
    setState(() {
      isScanCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFlashOn = !isFlashOn;
              });
              cameraController.toggleTorch();
            },
            icon: Icon(isFlashOn ? Icons.flash_on : Icons.flash_off),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    isFrontCamera = !isFrontCamera;
                  });
                  cameraController.switchCamera();
                },
                icon: const Icon(
                  Icons.flip_camera_android,
                  color: Colors.white,
                )),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            allowDuplicates: false,
            onDetect: (barcode, args) {
              if (!isScanCompleted) {
                isScanCompleted = true;
                final String code = barcode.rawValue ?? "";
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScanDetailsPage(
                      code: code,
                      closeScreen: closeScreen,
                    ),
                  ),
                );
              }
            },
          ),
          QRScannerOverlay(
            overlayColor: Colors.black26,
            borderColor: const Color(0xFF456EFE),
            borderStrokeWidth: 5,
            borderRadius: 12,
          ),
          const Align(
            alignment: AlignmentDirectional(0, -0.8),
            child: Text(
              'Scan shop\'s QR',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
