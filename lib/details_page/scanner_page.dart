import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerPage extends StatefulWidget {
 

   final void Function(Barcode?) scannedData;
 
  const ScannerPage(
      {super.key, 
       required this.scannedData,
     });

  @override
  State<StatefulWidget> createState() => _ScannerPage();
}

class _ScannerPage extends State<ScannerPage> {
  BarcodeCapture? barcode;
  MobileScannerController cameraController =
      MobileScannerController(detectionSpeed: DetectionSpeed.normal);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PopScope(
      onPopInvoked: (didPop) async {
        return;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: scannerAppBar('scanner', cameraController, context),
        body: showScannerAndOverlay(),
      ),
    );
  }

  captureBarcode() {
    try {
      if (barcode != null) {
        final List<Barcode> barcodes = barcode!.barcodes;
          widget.scannedData(barcodes[0]);
      }
    } catch (e) {}
  }

  Widget showScannerAndOverlay() {
    if ((barcode == null)) {
      return Stack(
        children: [
          Center(child: CircularProgressIndicator()),
          MobileScanner(
            controller: cameraController,
            errorBuilder: (context, error, child) {
              if (error.errorCode.name == 'permissionDenied') {
                print(
                    'You are not given the permisssion to use Camera, please update this in Camera settings under Site watch premium');
              } else {
                //return showAlertDialog(error.errorDetails!.message.toString());
                return Container();
              }
              return Container();
            },
            overlay: overlay(context, Colors.black.withOpacity(0.5)),
            onDetect: ((capture) {
              setState(() {
                this.barcode = capture;
              });
              captureBarcode();
            }),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget overlay(BuildContext context, Color overlayColour) {
    double scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 330.0;

    return Stack(children: [
      ColorFiltered(
        colorFilter: ColorFilter.mode(overlayColour, BlendMode.srcOut),
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.red, backgroundBlendMode: BlendMode.dstOut),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: scanArea,
                width: scanArea,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: CustomPaint(
          foregroundPainter: BorderPainter(),
          child: SizedBox(
            width: scanArea + 25,
            height: scanArea + 25,
          ),
        ),
      ),
    ]);
  }
}

AppBar scannerAppBar(String title, MobileScannerController cameraController,
    BuildContext context) {
  var size = MediaQuery.of(context).size;
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(
        Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
        color: Colors.grey,
      ),
    ),
    title: Text(
      title,
      style: TextStyle(fontSize: size.width * 0.05, color: Colors.grey),
    ),
    actions: [
      // IconButton(
      //   color: Colors.white,
      //   icon: ValueListenableBuilder(
      //     valueListenable: cameraController.torchState,
      //     builder: (context, state, child) {
      //       switch (state as TorchState) {
      //         case TorchState.off:
      //           return const Icon(Icons.flash_off, color: Colors.grey);
      //         case TorchState.on:
      //           return const Icon(Icons.flash_on, color: Colors.yellow);
      //       }
      //     },
      //   ),
      //   iconSize: size.height * 0.05,
      //   onPressed: () => cameraController.toggleTorch(),
      // ),
      const SizedBox(width: 20)
    ],
  );
}

/// The state of the flashlight.
enum TorchState {
  /// The flashlight is off.
  off(0),

  /// The flashlight is on.
  on(1);

  const TorchState(this.rawValue);

  factory TorchState.fromRawValue(int value) {
    switch (value) {
      case 0:
        return TorchState.off;
      case 1:
        return TorchState.on;
      default:
        throw ArgumentError.value(value, 'value', 'Invalid raw value.');
    }
  }

  /// The raw value for the torch state.
  final int rawValue;
}

// Creates the white borders
class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const width = 4.0;
    const radius = 20.0;
    const tRadius = 3 * radius;
    final rect = Rect.fromLTWH(
      width,
      width,
      size.width - 2 * width,
      size.height - 2 * width,
    );
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(radius));
    const clippingRect0 = Rect.fromLTWH(
      0,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect1 = Rect.fromLTWH(
      size.width - tRadius,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect2 = Rect.fromLTWH(
      0,
      size.height - tRadius,
      tRadius,
      tRadius,
    );
    final clippingRect3 = Rect.fromLTWH(
      size.width - tRadius,
      size.height - tRadius,
      tRadius,
      tRadius,
    );

    final path = Path()
      ..addRect(clippingRect0)
      ..addRect(clippingRect1)
      ..addRect(clippingRect2)
      ..addRect(clippingRect3);

    canvas.clipPath(path);
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = width,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class BarReaderSize {
  static double width = 200;
  static double height = 200;
}

class OverlayWithHolePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black54;
    canvas.drawPath(
        Path.combine(
          PathOperation.difference,
          Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
          Path()
            ..addOval(Rect.fromCircle(
                center: Offset(size.width - 44, size.height - 44), radius: 40))
            ..close(),
        ),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

@override
bool shouldRepaint(CustomPainter oldDelegate) {
  return false;
}
