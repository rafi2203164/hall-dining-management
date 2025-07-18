import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  int availableTokens = 5;
  bool isScanned = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  void onQRViewCreated(QRViewController ctrl) {
    controller = ctrl;
    ctrl.scannedDataStream.listen((scanData) {
      if (!isScanned) {
        isScanned = true;
        handleScan(scanData.code);
      }
    });
  }

  void handleScan(String? code) {
    final now = DateTime.now();
    final hour = now.hour;

    bool isLunchTime = hour >= 13 && hour < 15;
    bool isDinnerTime = hour >= 20 && hour < 22;

    if (code == null || code.trim() != 'token_use') {
      showSnackBar("Invalid QR Code. Please scan a valid meal token.");
      return;
    }

    if (!isLunchTime && !isDinnerTime) {
      showSnackBar("Tokens can only be used between 1–3 PM or 8–10 PM.");
      return;
    }

    if (availableTokens <= 0) {
      showSnackBar("You don't have any tokens left.");
      return;
    }

    setState(() {
      availableTokens--;
    });

    showSnackBar("Token used successfully! Remaining tokens: $availableTokens");

    controller?.pauseCamera();
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));

    Future.delayed(Duration(seconds: 2), () {
      if (mounted) Navigator.pop(context);
    });
  }

  String formatTime(DateTime time) {
    int hour = time.hour;
    int minute = time.minute;
    String suffix = 'AM';

    if (hour >= 12) {
      suffix = 'PM';
      if (hour > 12) hour -= 12;
    } else if (hour == 0) {
      hour = 12;
    }

    String minuteStr = minute.toString().padLeft(2, '0');
    return '$hour:$minuteStr $suffix';
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String currentTime = formatTime(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        backgroundColor: Colors.blue[300],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.blue,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 250,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'Current Time: $currentTime',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Lunch: 1–3 PM | Dinner: 8–10 PM',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Available Tokens: $availableTokens',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Scan a valid QR code to redeem a meal',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
