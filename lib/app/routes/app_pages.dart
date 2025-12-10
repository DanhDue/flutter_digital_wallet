// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:get/get.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../styles/app_themes.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/intro/intro/bindings/intro_binding.dart';
import '../modules/intro/intro/views/intro_view.dart';
import '../modules/intro/start/bindings/start_binding.dart';
import '../modules/intro/start/views/start_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/onboard/bindings/onboard_binding.dart';
import '../modules/onboard/views/onboard_view.dart';
import '../modules/password_creation/bindings/password_creation_binding.dart';
import '../modules/password_creation/views/password_creation_view.dart';
import '../modules/sample/api_testing/bindings/api_testing_binding.dart';
import '../modules/sample/api_testing/views/api_testing_view.dart';
import '../modules/sample/networking_sample/bindings/networking_sample_binding.dart';
import '../modules/sample/networking_sample/views/networking_sample_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/wallet_creation/wallet_creation/bindings/wallet_creation_binding.dart';
import '../modules/wallet_creation/wallet_creation/views/wallet_creation_view.dart';
import '../modules/wallet_creation/wallet_import/bindings/wallet_import_binding.dart';
import '../modules/wallet_creation/wallet_import/views/wallet_import_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ONBOARD;

  static final routes = [
    GetPage(name: _Paths.HOME, page: () => HomeView(), binding: HomeBinding()),
    GetPage(name: _Paths.LOGIN, page: () => const LoginView(), binding: LoginBinding()),
    GetPage(
      name: _Paths.TALKER,
      page: () => TalkerScreen(talker: Get.find<Talker>(), theme: talkerTheme),
    ),
    GetPage(name: _Paths.SPLASH, page: () => SplashView(), binding: SplashBinding()),
    GetPage(name: _Paths.START, page: () => StartView(), binding: StartBinding()),
    GetPage(name: _Paths.INTRO, page: () => IntroView(), binding: IntroBinding()),
    GetPage(
      name: _Paths.WALLET_IMPORT,
      page: () => WalletImportView(),
      binding: WalletImportBinding(),
    ),
    GetPage(
      name: _Paths.WALLET_CREATION,
      page: () => WalletCreationView(),
      binding: WalletCreationBinding(),
    ),
    GetPage(
      name: _Paths.PASSWORD_CREATION,
      page: () => PasswordCreationView(),
      binding: PasswordCreationBinding(),
    ),
    GetPage(name: _Paths.ONBOARD, page: () => OnboardView(), binding: OnboardBinding()),
    GetPage(name: _Paths.API_TESTING, page: () => ApiTestingView(), binding: ApiTestingBinding()),
    GetPage(
      name: _Paths.NETWORKING_SAMPLE,
      page: () => NetworkingSampleView(),
      binding: NetworkingSampleBinding(),
    ),
  ];
}
