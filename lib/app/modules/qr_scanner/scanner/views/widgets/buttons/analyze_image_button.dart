// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:dart_helper_utils/dart_helper_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// Button widget for analyze image function
class AnalyzeImageButton extends StatelessWidget {
  /// Construct a new [AnalyzeImageButton] instance.
  const AnalyzeImageButton({required this.controller, super.key, this.barcodeIsScanned});

  /// Controller which is used to call analyzeImage
  final MobileScannerController controller;

  final ValueChanged<String?>? barcodeIsScanned;

  Future<void> _onPressed(BuildContext context) async {
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Analyze image is not supported on web'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    final picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    }

    final BarcodeCapture? barcodes = await controller.analyzeImage(image.path);

    if (!context.mounted) {
      return;
    }

    final snackBar =
        barcodes != null && barcodes.barcodes.isNotEmpty
            ? const SnackBar(content: Text('Barcode found!'), backgroundColor: Colors.green)
            : const SnackBar(content: Text('No barcode found!'), backgroundColor: Colors.red);

    if (barcodes?.barcodes.isNotEmptyOrNull == true) {
      barcodeIsScanned?.call(barcodes?.barcodes.first.rawValue);
    }

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.white,
      icon: const Icon(Icons.image),
      iconSize: 32,
      onPressed: () => _onPressed(context),
    );
  }
}
