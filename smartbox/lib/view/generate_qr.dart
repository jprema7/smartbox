import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:smartbox/constants.dart';

class GenerateQR extends StatefulWidget {
  const GenerateQR({super.key});

  @override
  State<GenerateQR> createState() => _GenerateQRState();
}

class _GenerateQRState extends State<GenerateQR> {

  GlobalKey globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {

    String storageBoxID = generateStorageBoxID();

    return Scaffold(
      appBar: AppBar(
        title: Text('Generate QR'),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 5,
              child: Center(
                  child: RepaintBoundary(
                      key: globalKey,
                      child: QrImageView(
                        backgroundColor: Colors.white,
                        data: storageBoxID,
                        version: QrVersions.auto,
                        size: 200.0,
                      )
                  ),
              )
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: MaterialButton(
                      onPressed: () async {
                        await printQrCode();
                      },
                      child: const Text(
                        'Print QR Code',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      )),
                ),
                VerticalDivider(
                  thickness: 1.0,
                ),
                Expanded(
                  flex: 1,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.ADD_STORAGE_HEADER_DETAILS, arguments: {'storage_box_id': storageBoxID });
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String generateStorageBoxID() {
    int min = 1000000;
    int max = 9999999;
    return '${ min + Random().nextInt(max - min)}';
  }

  Future<void> printQrCode() async {
    // Convert render object to image bytes
    RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage(pixelRatio: 0.5);
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    // Generate PDF doc
    final doc = pw.Document();
    pw.MemoryImage memoryImage = pw.MemoryImage(pngBytes);

    // Add QR Image page to PDG doc
    doc.addPage(pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(memoryImage, fit: pw.BoxFit.scaleDown),
          ); // Center
        })); // Page

    // Print
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }
}
