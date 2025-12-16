// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/bean/app_configurations/app_configurations.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/data/local/impl/selected_account_storage_impl.dart';
import 'package:d3_wallet/data/local/impl/token_account_storage_impl.dart';
import 'package:d3_wallet/data/local/impl/wallets_storage_impl.dart';
import 'package:d3_wallet/data/local/selected_account_storage.dart';
import 'package:d3_wallet/data/local/token_account_storage.dart';
import 'package:d3_wallet/data/local/wallets_storage.dart';
import 'package:d3_wallet/data/remote/app_uri.dart';
import 'package:d3_wallet/data/remote/dio_factory.dart';
import 'package:d3_wallet/data/remote/token_client/token_client.dart';
import 'package:d3_wallet/data/remote/transaction_client/transaction_client.dart';
import 'package:d3_wallet/data/remote/wallet_client/wallet_client.dart';
import 'package:d3_wallet/data/repositories/app_configs_repository.dart';
import 'package:d3_wallet/data/repositories/impl/app_configs_repository_impl.dart';
import 'package:d3_wallet/data/repositories/impl/secure_storage_repository_impl.dart';
import 'package:d3_wallet/data/repositories/impl/token_repository_impl.dart';
import 'package:d3_wallet/data/repositories/impl/transaction_repository_impl.dart';
import 'package:d3_wallet/data/repositories/impl/wallet_repository_impl.dart';
import 'package:d3_wallet/data/repositories/secure_keys.dart';
import 'package:d3_wallet/data/repositories/secure_storage_repository.dart';
import 'package:d3_wallet/data/repositories/token_repository.dart';
import 'package:d3_wallet/data/repositories/transaction_repository.dart';
import 'package:d3_wallet/data/repositories/wallet_repository.dart';
import 'package:d3_wallet/utils/biometric_auth/biometric_authenticator.dart';
import 'package:d3_wallet/utils/biometric_auth/impl/biometric_authenticator_impl.dart';
import 'package:d3_wallet/utils/extensions/string_ext.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';

class AppGlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FlutterSecureStorage(), fenix: true);
    Get.lazyPut<SecureStorageRepository>(() => SecureStorageRepositoryImpl(), fenix: true);
    Get.lazyPut<SecureKeys>(() => SecureKeys(), fenix: true);
    Get.lazyPut<SelectedAccountStorage>(() => SelectedAccountStorageImpl(), fenix: true);
    Get.lazyPut<WalletsStorage>(() => WalletsStorageImpl(), fenix: true);
    Get.lazyPut<TokenAccountStorage>(() => TokenAccountStorageImpl(), fenix: true);
    Hive.registerAdapter(AppConfigurationsAdapter());
    Hive.registerAdapter(WalletResponseObjectAdapter());
    Get.lazyPut(() => DioFactory().dio, fenix: true);
    Get.lazyPut<AppConfigsRepository>(() => AppConfigurationsRepositoryImpl(), fenix: true);
    Get.lazyPut<LocalAuthentication>(() => LocalAuthentication(), fenix: true);
    Get.lazyPut<BiometricAuthenticator>(() => BiometricAuthenticatorImpl(), fenix: true);
    Get.lazyPut(
      () => WalletClient(Get.find(), baseUrl: AppUri.wallets.buildAppUri()),
      fenix: true,
    );
    Get.lazyPut<WalletRepository>(() => WalletRepositoryImpl(), fenix: true);
    Get.lazyPut(() => TokenClient(Get.find(), baseUrl: AppUri.tokens.buildAppUri()), fenix: true);
    Get.lazyPut<TokenRepository>(() => TokenRepositoryImpl(), fenix: true);
    Get.lazyPut(
      () => TransactionClient(Get.find(), baseUrl: AppUri.transactions.buildAppUri()),
      fenix: true,
    );
    Get.lazyPut<TransactionRepository>(() => TransactionRepositoryImpl(), fenix: true);
  }
}
