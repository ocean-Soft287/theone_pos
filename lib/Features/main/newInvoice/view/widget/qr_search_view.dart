import 'dart:io';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:flutter/material.dart';

class QRSearchView extends StatelessWidget {
  GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  QRSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRView(
        key: qrKey,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.blue,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
        ),
        onQRViewCreated: (QRViewController controller) {
          Future.microtask(() => _onQRViewCreated(controller, context));
        },
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller, BuildContext context) {
    if (Platform.isIOS) {
      controller.resumeCamera();
    }

    controller.scannedDataStream.listen((scanData) {
      debugPrint("Scanned QR Code: ${scanData.code}");
      controller.pauseCamera();
      Navigator.pop(context, scanData.code);
    });
  }
}
