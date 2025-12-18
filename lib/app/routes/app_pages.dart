// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:get/get.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../styles/app_themes.dart';
import '../modules/comming_soon_modal/bindings/comming_soon_modal_binding.dart';
import '../modules/comming_soon_modal/views/comming_soon_modal_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/intro/intro/bindings/intro_binding.dart';
import '../modules/intro/intro/views/intro_view.dart';
import '../modules/intro/start/bindings/start_binding.dart';
import '../modules/intro/start/views/start_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/my_qr/bindings/my_qr_binding.dart';
import '../modules/my_qr/views/my_qr_view.dart';
import '../modules/my_tokens/bindings/my_tokens_binding.dart';
import '../modules/my_tokens/views/my_tokens_view.dart';
import '../modules/my_wallets/bindings/my_wallets_binding.dart';
import '../modules/my_wallets/views/my_wallets_view.dart';
import '../modules/my_wallets/wallet_card/bindings/wallet_card_widget_binding.dart';
import '../modules/my_wallets/wallet_card/views/wallet_card_view.dart';
import '../modules/network_selection/bindings/network_selection_binding.dart';
import '../modules/network_selection/views/network_selection_view.dart';
import '../modules/onboard/bindings/onboard_binding.dart';
import '../modules/onboard/mnemonic_confirmation/bindings/mnemonic_confirmation_binding.dart';
import '../modules/onboard/mnemonic_confirmation/views/mnemonic_confirmation_view.dart';
import '../modules/onboard/mnemonic_creation/bindings/mnemonic_creation_binding.dart';
import '../modules/onboard/mnemonic_creation/views/mnemonic_creation_view.dart';
import '../modules/onboard/mnemonic_description/bindings/mnemonic_description_binding.dart';
import '../modules/onboard/mnemonic_description/views/mnemonic_description_view.dart';
import '../modules/onboard/mnemonic_warning/bindings/mnemonic_warning_binding.dart';
import '../modules/onboard/mnemonic_warning/views/mnemonic_warning_view.dart';
import '../modules/onboard/s_r_p_description/bindings/s_r_p_description_binding.dart';
import '../modules/onboard/s_r_p_description/views/s_r_p_description_view.dart';
import '../modules/onboard/views/onboard_view.dart';
import '../modules/password_creation/bindings/password_creation_binding.dart';
import '../modules/password_creation/views/password_creation_view.dart';
import '../modules/payment/request_payment/bindings/request_payment_binding.dart';
import '../modules/payment/request_payment/views/request_payment_view.dart';
import '../modules/payment/request_payment_results/bindings/request_payment_results_binding.dart';
import '../modules/payment/request_payment_results/views/request_payment_results_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/profile_detail/bindings/profile_detail_binding.dart';
import '../modules/profile/profile_detail/views/profile_detail_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/qr_scanner/bindings/qr_scanner_binding.dart';
import '../modules/qr_scanner/qr/bindings/qr_binding.dart';
import '../modules/qr_scanner/qr/views/qr_view.dart';
import '../modules/qr_scanner/scanner/bindings/scanner_binding.dart';
import '../modules/qr_scanner/scanner/views/scanner_view.dart';
import '../modules/qr_scanner/views/qr_scanner_view.dart';
import '../modules/sample/api_testing/bindings/api_testing_binding.dart';
import '../modules/sample/api_testing/views/api_testing_view.dart';
import '../modules/sample/networking_sample/bindings/networking_sample_binding.dart';
import '../modules/sample/networking_sample/views/networking_sample_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/transactions/bindings/transactions_binding.dart';
import '../modules/transactions/views/transactions_view.dart';
import '../modules/transfer/transfer/bindings/transfer_binding.dart';
import '../modules/transfer/transfer/views/transfer_view.dart';
import '../modules/transfer/transfer_confirmation/bindings/transfer_confirmation_binding.dart';
import '../modules/transfer/transfer_confirmation/views/transfer_confirmation_view.dart';
import '../modules/trends/bindings/trends_binding.dart';
import '../modules/trends/views/trends_view.dart';
import '../modules/wallet_creation/wallet_creation/bindings/wallet_creation_binding.dart';
import '../modules/wallet_creation/wallet_creation/views/wallet_creation_view.dart';
import '../modules/wallet_creation/wallet_import/bindings/wallet_import_binding.dart';
import '../modules/wallet_creation/wallet_import/views/wallet_import_view.dart';
import '../modules/wallet_creation_successfully/bindings/wallet_creation_successfully_binding.dart';
import '../modules/wallet_creation_successfully/views/wallet_creation_successfully_view.dart';
import '../modules/wallet_token_info/bindings/wallet_token_info_binding.dart';
import '../modules/wallet_token_info/views/wallet_token_info_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MY_TOKENS;

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
      children: [
        GetPage(
          name: _Paths.MNEMONIC_DESCRIPTION,
          page: () => MnemonicDescriptionView(),
          binding: MnemonicDescriptionBinding(),
        ),
        GetPage(
          name: _Paths.MNEMONIC_CREATION,
          page: () => const MnemonicCreationView(),
          binding: MnemonicCreationBinding(),
        ),
        GetPage(
          name: _Paths.MNEMONIC_CONFIRMATION,
          page: () => const MnemonicConfirmationView(),
          binding: MnemonicConfirmationBinding(),
        ),
        GetPage(
          name: _Paths.SRP_DESCRIPTION,
          page: () => SRPDescriptionView(bindingCreator: () => SRPDescriptionBinding()),
        ),
        GetPage(
          name: _Paths.MNEMONIC_WARNING,
          page: () => MnemonicWarningView(),
          binding: MnemonicWarningBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.WALLET_CREATION_SUCCESSFULLY,
      page: () => WalletCreationSuccessfullyView(),
      binding: WalletCreationSuccessfullyBinding(),
    ),
    GetPage(
      name: _Paths.MY_WALLETS,
      page: () => MyWalletsView(bindingCreator: () => MyWalletsBinding()),
      children: [
        GetPage(
          name: _Paths.WALLET_CARD_WIDGET,
          page: () => WalletCardView(),
          binding: WalletCardBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.WALLET_TOKEN_INFO,
      page: () => const WalletTokenInfoView(),
      binding: WalletTokenInfoBinding(),
    ),
    GetPage(
      name: _Paths.COMMING_SOON_MODAL,
      page: () => CommingSoonModalView(bindingCreator: () => CommingSoonModalBinding()),
    ),
    GetPage(
      name: _Paths.NETWORK_SELECTION,
      page: () => const NetworkSelectionView(),
      binding: NetworkSelectionBinding(),
    ),
    GetPage(name: _Paths.MY_QR, page: () => const MyQrView(), binding: MyQrBinding()),
    GetPage(
      name: _Paths.TRANSACTIONS,
      page: () => TransactionsView(),
      binding: TransactionsBinding(),
    ),
    GetPage(name: _Paths.QR_SCANNING, page: () => QRScannerView(), binding: QRScannerBinding()),
    GetPage(name: _Paths.TRENDS, page: () => TrendsView(), binding: TrendsBinding()),
    GetPage(name: _Paths.PROFILE, page: () => ProfileView(), binding: ProfileBinding()),
    GetPage(
      name: _Paths.PROFILE_DETAIL,
      page: () => ProfileDetailView(),
      binding: ProfileDetailBinding(),
    ),
    GetPage(name: _Paths.SCANNER, page: () => const ScannerView(), binding: ScannerBinding()),
    GetPage(name: _Paths.QR, page: () => const QRView(), binding: QRBinding()),
    GetPage(
      name: _Paths.TRANSFER,
      page: () => TransferView(),
      binding: TransferBinding(),
      children: [
        GetPage(
          name: _Paths.TRANSFER_CONFIRMATION,
          page: () => TransferConfirmationView(),
          binding: TransferConfirmationBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.REQUEST_PAYMENT,
      page: () => RequestPaymentView(),
      binding: RequestPaymentBinding(),
    ),
    GetPage(
      name: _Paths.REQUEST_PAYMENT_RESULTS,
      page: () => RequestPaymentResultsView(),
      binding: RequestPaymentResultsBinding(),
    ),
    GetPage(name: _Paths.MY_TOKENS, page: () => MyTokensView(), binding: MyTokensBinding()),
  ];
}
