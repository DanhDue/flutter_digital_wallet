// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/app/modules/qr_scanner/scanner/views/widgets/buttons/analyze_image_button.dart';
import 'package:d3_wallet/app/modules/qr_scanner/scanner/views/widgets/buttons/pause_button.dart';
import 'package:d3_wallet/app/modules/qr_scanner/scanner/views/widgets/buttons/start_stop_button.dart';
import 'package:d3_wallet/app/modules/qr_scanner/scanner/views/widgets/buttons/switch_camera_button.dart';
import 'package:d3_wallet/app/modules/qr_scanner/scanner/views/widgets/buttons/toggle_flashlight_button.dart';
import 'package:d3_wallet/app/modules/qr_scanner/scanner/views/widgets/qr_scanner_overlay_shape.dart';
import 'package:d3_wallet/app/modules/qr_scanner/scanner/views/widgets/scanner_error_widget.dart';
import 'package:d3_wallet/app/modules/qr_scanner/scanner/views/widgets/zoom_scale_slider_widget.dart';
import 'package:d3_wallet/app/routes/app_pages.dart';
import 'package:d3_wallet/app/routes/navigation_arguments.dart';
import 'package:d3_wallet/data/bean/response/mint_token_object/mint_token_object.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:d3_wallet/utils/qr_utils.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../controllers/scanner_controller.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({super.key, this.selectedWallet});

  final WalletResponseObject? selectedWallet;

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  final controller = Get.put(ScannerController(), permanent: false);
  late MobileScannerController? mobileScannerController;

  // A scan window does work on web, but not the overlay to preview the scan
  // window. This is why we disable it here for web examples.
  bool useScanWindow = !kIsWeb;

  bool autoZoom = false;
  bool invertImage = false;
  bool returnImage = false;

  Size desiredCameraResolution = const Size(1920, 1080);
  DetectionSpeed detectionSpeed = DetectionSpeed.unrestricted;
  int detectionTimeoutMs = 1000;

  bool useBarcodeOverlay = true;
  BoxFit boxFit = BoxFit.fill;
  bool enableLifecycle = false;

  /// Hides the MobileScanner widget while the MobileScannerController is
  /// rebuilding
  bool hideMobileScannerWidget = false;

  List<BarcodeFormat> selectedFormats = [];

  MobileScannerController initController() => MobileScannerController(
    autoStart: false,
    cameraResolution: desiredCameraResolution,
    detectionSpeed: detectionSpeed,
    detectionTimeoutMs: detectionTimeoutMs,
    formats: selectedFormats,
    returnImage: returnImage,
    // torchEnabled: true,
    invertImage: invertImage,
    autoZoom: autoZoom,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      Fimber.d("FocusDetector - WidgetsBinding: addPostFrameCallback");
    });
    controller.setupInputs(widget.selectedWallet);
    mobileScannerController = initController();
  }

  @override
  void dispose() async {
    super.dispose();
    await mobileScannerController?.dispose();
    mobileScannerController = null;
    Get.delete<ScannerController>();
  }

  @override
  Widget build(BuildContext context) {
    late final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(const Offset(0, -100)),
      width: 300,
      height: 300,
    );

    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea =
        (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400)
            ? 150.0
            : 300.0;

    return GetBuilder(
      init: controller,
      builder:
          (controller) => FocusDetector(
            onFocusLost: () {
              Fimber.d("FocusDetector - onFocusLost: ${DateTime.now()}");
            },
            onFocusGained: () {
              Fimber.d("FocusDetector - onFocusGained: ${DateTime.now()}");
            },
            onVisibilityLost: () {
              Fimber.d("FocusDetector - onVisibilityLost: ${DateTime.now()}");
              mobileScannerController?.stop();
            },
            onVisibilityGained: () {
              Fimber.d("FocusDetector - onVisibilityGained: ${DateTime.now()}");
              mobileScannerController?.start();
            },
            onForegroundLost: () {
              Fimber.d("FocusDetector - onForegroundLost: ${DateTime.now()}");
            },
            onForegroundGained: () {
              Fimber.d("FocusDetector - onForegroundGained: ${DateTime.now()}");
            },
            child: SafeArea(
              top: false,
              bottom: false,
              child: Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child:
                          mobileScannerController == null || hideMobileScannerWidget
                              ? const Placeholder()
                              : Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  MobileScanner(
                                    scanWindow: useScanWindow ? scanWindow : null,
                                    controller: mobileScannerController,
                                    errorBuilder: (context, error) {
                                      return ScannerErrorWidget(error: error);
                                    },
                                    fit: boxFit,
                                    onDetect: (barcodes) {
                                      mobileScannerController?.pause();
                                      Fimber.d(barcodes.barcodes.first.rawValue ?? "");
                                      _parseUris(
                                        isShowFullScreen: controller.showFullScreen.value,
                                        url: barcodes.barcodes.first.rawValue ?? '',
                                      );
                                    },
                                  ),
                                  if (useScanWindow)
                                    Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: ShapeDecoration(
                                        shape: QrScannerOverlayShape(
                                          borderColor: Colors.red,
                                          borderRadius: 10,
                                          borderLength: 30,
                                          borderWidth: 10,
                                          cutOutSize: scanArea,
                                          overlayColor: Colors.black.withValues(alpha: 0.5),
                                        ),
                                      ),
                                    ),
                                  if (returnImage)
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Card(
                                        clipBehavior: Clip.hardEdge,
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: StreamBuilder<BarcodeCapture>(
                                            stream: mobileScannerController?.barcodes,
                                            builder: (context, snapshot) {
                                              final BarcodeCapture? barcode = snapshot.data;
                                              if (barcode == null) {
                                                return const Center(
                                                  child: Text(
                                                    'Your scanned barcode will appear here',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                );
                                              }

                                              final Uint8List? barcodeImage = barcode.image;

                                              if (barcodeImage == null) {
                                                return const Center(
                                                  child: Text('No image for this barcode.'),
                                                );
                                              }

                                              return Image.memory(
                                                barcodeImage,
                                                fit: BoxFit.cover,
                                                gaplessPlayback: true,
                                                errorBuilder: (context, error, stackTrace) {
                                                  return Center(
                                                    child: Text(
                                                      'Could not decode image bytes. $error',
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  Obx(
                                    () =>
                                        controller.showFullScreen.value == true
                                            ? InkWell(
                                              onTap: () {
                                                Get.back(result: null);
                                              },
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                    top: 63,
                                                    right: 16,
                                                  ),
                                                  child: Card(
                                                    clipBehavior: Clip.hardEdge,
                                                    shape: RoundedRectangleBorder(
                                                      side: const BorderSide(color: Colors.white),
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    child: Container(
                                                      width: 30,
                                                      height: 30,
                                                      alignment: Alignment.center,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.center,
                                                        mainAxisSize: MainAxisSize.max,
                                                        children: [
                                                          Icon(
                                                            size: 24,
                                                            Icons.close,
                                                            color: context.appThemes.trueBlue,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                            : SizedBox.shrink(),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      if (!kIsWeb && mobileScannerController != null)
                                        ZoomScaleSlider(controller: mobileScannerController!),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          if (mobileScannerController != null) ...[
                                            ToggleFlashlightButton(
                                              controller: mobileScannerController!,
                                            ),
                                            StartStopButton(controller: mobileScannerController!),
                                            PauseButton(controller: mobileScannerController!),
                                            SwitchCameraButton(
                                              controller: mobileScannerController!,
                                            ),
                                            AnalyzeImageButton(
                                              controller: mobileScannerController!,
                                              barcodeIsScanned: (url) {
                                                mobileScannerController?.pause();
                                                Fimber.d("barcode: $url");
                                                _parseUris(
                                                  isShowFullScreen:
                                                      controller.showFullScreen.value,
                                                  url: url,
                                                );
                                              },
                                            ),
                                          ],
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                    ),
                    Container(width: double.infinity, height: 1, color: context.appThemes.ink5),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  void _parseUris({String? url, required isShowFullScreen}) {
    if (controller.showFullScreen.value) {
      Get.back(result: url);
      return;
    } else {
      final uri = Uri.parse(url ?? '');
      final queryParameters = uri.queryParameters;
      if (queryParameters.isNotEmpty) {
        Get.toNamed(
          Routes.TRANSFER_CONFIRMATION,
          arguments: {
            NavigationArguments.fromQRScanner: true,
            NavigationArguments.srcWallet: controller.selectedWallet.value,
            NavigationArguments.destWallet: WalletResponseObject(
              address: queryParameters["address"],
            ),
            NavigationArguments.amount: queryParameters["amount"],
            NavigationArguments.mintToken: MintTokenObject(
              name: queryParameters["unit"],
              symbol: queryParameters["unit"],
            ),
          },
        );
      } else {
        Get.toNamed(
          Routes.TRANSFER,
          arguments: {
            NavigationArguments.wallet: controller.selectedWallet.value,
            NavigationArguments.walletAddress: QrUtils.instance
                .retrieveWalletAddressFromTransferQr(url ?? ''),
          },
        );
      }
    }
  }
}
