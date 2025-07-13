import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer_library.dart';

class PrintThermalOrPdf extends StatelessWidget {
  const PrintThermalOrPdf({
    super.key,
    required this.isPrint,
    required this.child,
    required this.onInitialized,
    this.repaintKey,
  });

  final bool isPrint;
  final Widget child;

  final void Function(ReceiptController) onInitialized;

  final GlobalKey? repaintKey;

  @override
  Widget build(BuildContext context) {
    if (isPrint) {
      return Receipt(
        defaultTextStyle: TextStyle(fontWeight: FontWeight.w900,fontSize: 30),
        builder: (context) => ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 600,
          ),
          child: child,
        ),
        onInitialized: onInitialized,
      );
    } else {
      return RepaintBoundary(
        key: repaintKey,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(8),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 600,

            ),
            child: child,
          ),
        ),
      );
    }
  }
}
