// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/app/app_global_bindings.dart';
import 'package:d3_wallet/app/pre_app_initialization_bindings.dart';
import 'package:d3_wallet/app/routes/app_pages.dart';
import 'package:d3_wallet/base/widgets/custom_loading_widget.dart';
import 'package:d3_wallet/generated/colors.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:d3_wallet/utils/constants.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path_provider/path_provider.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() async {
  // debugRepaintRainbowEnabled = true;
  // Logging configuration.
  Fimber.plantTree(DebugTree.elapsed());

  WidgetsFlutterBinding.ensureInitialized();

  // make flutter draw behind navigation bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  PreAppInitializationBindings().dependencies();
  final talker = Get.find<Talker>();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      OverlaySupport.global(
        child: GetMaterialApp(
          color: Colors.transparent,
          theme: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            dividerColor: Colors.transparent,
            brightness: Brightness.light,
            scaffoldBackgroundColor: AppColors.white,
            extensions: [lightAppThemes],
          ),
          darkTheme: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            dividerColor: Colors.transparent,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: AppColors.black,
            extensions: [darkAppThemes],
          ),
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          translationsKeys: AppTranslation.translations,
          locale: AppLocales.vnVI,
          initialBinding: AppGlobalBindings(),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          // builder: EasyLoading.init(
          //   builder: (context, widget) {
          //     EasyLoading.init();
          //     return MediaQuery(
          //       data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
          //       child: widget!,
          //     );
          //   },
          // ),
          builder: FlutterSmartDialog.init(
            loadingBuilder: (String msg) => CustomLoadingWidget(msg: msg),
          ),
          navigatorObservers: [FlutterSmartDialog.observer, TalkerRouteObserver(talker)],
        ),
      ),
    );
  });
  configLoading();
}

void configLoading() {
  SmartDialog.config
    ..custom = SmartConfigCustom(
      maskColor: Colors.black.withValues(alpha: 0.35),
      useAnimation: true,
    )
    ..attach = SmartConfigAttach(animationType: SmartAnimationType.scale, usePenetrate: false)
    ..loading = SmartConfigLoading(
      clickMaskDismiss: false,
      leastLoadingTime: const Duration(milliseconds: 0),
    )
    ..toast = SmartConfigToast(
      intervalTime: const Duration(milliseconds: 100),
      displayTime: const Duration(milliseconds: 2000),
    );
}
