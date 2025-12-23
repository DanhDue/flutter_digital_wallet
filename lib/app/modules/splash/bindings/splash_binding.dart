// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/remote/app_client/health_check_client.dart';
import 'package:d3_wallet/data/remote/app_uri.dart';
import 'package:d3_wallet/data/remote/dio_factory.dart';
import 'package:d3_wallet/data/repositories/impl/service_checking_repository_impl.dart';
import 'package:d3_wallet/data/repositories/service_checking_repository.dart';
import 'package:d3_wallet/utils/constants.dart';
import 'package:d3_wallet/utils/extensions/string_ext.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => DioFactory()
          .withReceiveTimeout(const Duration(seconds: DependencyInjections.HEALTHZ_TIMEOUT))
          .dio,
      tag: DependencyInjections.HEALTHZ,
      fenix: true,
    );
    Get.lazyPut(
      () => HealthCheckClient(
        Get.find(tag: DependencyInjections.HEALTHZ),
        baseUrl: AppUri.healthz.buildAppUri(),
      ),
      fenix: true,
    );
    Get.lazyPut<ServiceCheckingRepository>(() => ServiceCheckingRepositoryImpl());
    Get.lazyPut<SplashController>(() => SplashController());
  }
}
