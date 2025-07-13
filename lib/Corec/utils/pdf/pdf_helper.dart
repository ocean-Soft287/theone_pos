import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';
import 'package:flutter/material.dart';

class PdfHelper {
  static Future<void> convertWidgetToPdf(GlobalKey globalKey) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final pdf = pw.Document();

    RenderRepaintBoundary? boundary =
    globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    if (boundary == null) return;

    final ui.Image image = await boundary.toImage(pixelRatio: 4.0);
    final ByteData? byteData =
    await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    final imageProvider = pw.MemoryImage(pngBytes);

    final double imageWidth = image.width.toDouble();
    final double imageHeight = image.height.toDouble();
    final double aspectRatio = imageHeight / imageWidth;

    final double pageWidthMm = 72.0;
    final double pageWidthPt = pageWidthMm * PdfPageFormat.mm;
    final double pageHeightPt = pageWidthPt * aspectRatio;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat(pageWidthPt, pageHeightPt),
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(
              imageProvider,
              fit: pw.BoxFit.contain,
              width: pageWidthPt,
              height: pageHeightPt,
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  static Future<void> convertWidgetToPdfAndSendToWhatsapp(
      GlobalKey globalKey) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final pdf = pw.Document();

    RenderRepaintBoundary? boundary =
    globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    if (boundary == null) return;

    final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    final ByteData? byteData =
    await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    final imageProvider = pw.MemoryImage(pngBytes);

    final double imageWidth = image.width.toDouble();
    final double imageHeight = image.height.toDouble();
    final double aspectRatio = imageHeight / imageWidth;

    final double pageWidthMm = 58.0;
    final double pageWidthPt = pageWidthMm * PdfPageFormat.mm;
    final double pageHeightPt = pageWidthPt * aspectRatio;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat(pageWidthPt, pageHeightPt),
        build: (pw.Context context) {
          return pw.Image(
            imageProvider,
            fit: pw.BoxFit.fill,
            width: pageWidthPt,
            height: pageHeightPt,
          );
        },
      ),
    );

    final pdfBytes = await pdf.save();

    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/document.pdf');
    await tempFile.writeAsBytes(pdfBytes);

    await Share.shareXFiles(
      [XFile(tempFile.path)],
      text: '📄 Here is the PDF document',
    );
  }
}




class PrinterManager {
  final BuildContext context;
  ReceiptController? controller;

  PrinterManager(this.context);

  Future<void> printReceipt({required String address}) async {
    try {
      if (controller != null) {
        await controller!.print(address: address, delayTime: 1000);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('✅ جاري الطباعة إلى $address')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('⚠️ لم يتم تهيئة المتحكم')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ خطأ أثناء الطباعة: $e')),
      );
    }
  }

  Future<String?> selectDevice() async {
    try {
      final device = await FlutterBluetoothPrinter.selectDevice(context);
      return device?.address;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ خطأ أثناء اختيار الجهاز: $e')),
      );
      return null;
    }
  }
}