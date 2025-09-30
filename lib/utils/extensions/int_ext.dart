// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:intl/intl.dart';

extension IntExt on int? {
  String? retrieveMoneyAmountFromSNumber() {
    return NumberFormat(
      "#,##0",
      "en_US",
    ).format((double.tryParse(this?.toString() ?? "0"))?.toInt() ?? 0);
  }
}
