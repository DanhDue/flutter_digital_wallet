// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/data/bean/app_configurations/app_configurations.dart';

abstract class AppConfigsRepository {
  AppConfigurations? get appConfigurations;

  Future saveLocalPassword(String? password);

  Future saveAppConfigurations(AppConfigurations? appConfigurations);

  Future<AppConfigurations?> retrieveAppConfigurations();

  Future clearAppData();
}
