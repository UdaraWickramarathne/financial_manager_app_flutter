import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'scan_details_page.dart';

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
          const Padding(
            padding: EdgeInsets.only(right: 30),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isFlashOn = !isFlashOn;
              });
              cameraController.toggleTorch();
            },
            icon: Icon(isFlashOn ? Icons.flash_on : Icons.flash_off),
          ),
          IconButton(
              onPressed: (){
                setState(() {
                  isFrontCamera = !isFrontCamera;
                });
                cameraController.switchCamera();
              },
              icon: Icon(
                Icons.flip_camera_android,
                color: isFrontCamera ? Colors.white
                : Colors.black,
              )
          ),
        ],
        centerTitle: true,
        title: const Center(
          child: Text(
            'Scan',
            style: TextStyle(fontSize: 20),
          ),
        ),
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
            borderColor: Colors.lightBlue,
            borderStrokeWidth: 5,
            borderRadius: 12,
          ),
        ],
      ),
    );
  }
}
