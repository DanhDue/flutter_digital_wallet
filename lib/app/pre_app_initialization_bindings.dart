// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/good_log.dart';
import 'package:get/get.dart';
import 'package:talker_flutter/talker_flutter.dart';

class PreAppInitializationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => TalkerFlutter.init(
        settings: TalkerSettings(
          colors: {TalkerKey.verbose: AnsiPen()..yellow(), GoodLog.getKey: GoodLog.getPen},
        ),
      ),
      fenix: true,
    );
  }
}
