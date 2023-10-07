import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:smartbox/constants.dart';
class ScanQR extends StatefulWidget {
  const ScanQR({super.key});

  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR')),
      body: const Center(
          child: QRViewExample()
      ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    // TODO: is below controller check required?
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text(
                        'Barcode Type: ${describeEnum(
                            result!.format)}   Data: ${result!.code}')
                  else
                    const Text('Scan a code'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: FutureBuilder(
                          future: controller?.getFlashStatus(),
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return Text('Flash not available');
                            }

                            return snapshot.data!? IconButton(
                                icon: Icon(Icons.flash_on),
                                onPressed: () async {
                                    await toggleFlash();
                                }
                             ) : IconButton(
                                icon: Icon(Icons.flash_off),
                                onPressed: () async {
                                  await toggleFlash();
                                }
                            );
                          },
                        )
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: FutureBuilder(
                                future: controller?.getCameraInfo(),
                                builder: (context, snapshot) {
                                  if (snapshot.data != null) {
                                      return IconButton(
                                          onPressed: () async {
                                            await flipCamera();
                                          },
                                          icon: Icon(Icons.cameraswitch)
                                      );
                                  } else {
                                      return const Text('Loading');
                                  }
                          },
                        )
                      )
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: <Widget>[
                  //     Container(
                  //       margin: const EdgeInsets.all(8),
                  //       child: MaterialButton(
                  //         onPressed: () async {
                  //           await controller?.pauseCamera();
                  //         },
                  //         child: const Text('Pause',
                  //             style: TextStyle(fontSize: 20)),
                  //       ),
                  //     ),
                  //     Container(
                  //       margin: const EdgeInsets.all(8),
                  //       child: MaterialButton(
                  //         onPressed: () async {
                  //           await controller?.resumeCamera();
                  //         },
                  //         child: const Text('Resume',
                  //             style: TextStyle(fontSize: 20)),
                  //       ),
                  //     )
                  //   ],
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> toggleFlash() async {
    try {
      await controller?.toggleFlash();
      setState(() {});
    } on CameraException catch (exception) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Center(
                  child: Text(
                      '${exception.code} - ${exception.description!}')
              )
          )
      );
    }
  }

  Future<void> flipCamera() async {
    try {
      await controller?.flipCamera();
      setState(() {});
    } on CameraException catch (exception) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Center(
                  child: Text(
                      '${exception.code} - ${exception.description!}')
              )
          )
      );
    }
  }

  Future<void> toggleCamera() async {
    try {
      await controller?.toggleFlash();
      setState(() {});
    } on CameraException catch (exception) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Center(
                  child: Text(
                      '${exception.code} - ${exception.description!}')
              )
          )
      );
    }
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery
        .of(context)
        .size
        .width < 400 ||
        MediaQuery
            .of(context)
            .size
            .height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (controller, permission) => _onPermissionSet(context, controller, permission),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        Navigator.pushReplacementNamed(context, Routes.ADD_STORAGE_HEADER_DETAILS, arguments: {'storage_box_id': scanData.code});
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool permission) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $permission');
    if (!permission) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Center(child: Text('Enable permission to use Camera'))),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
