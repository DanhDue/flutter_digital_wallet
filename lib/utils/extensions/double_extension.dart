// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/utils/constants.dart';
import 'package:dart_helper_utils/dart_helper_utils.dart';

extension DoubleExt on double? {
  String? retrieveDoubleAmount(String region, {int decimalDigits = 3}) {
    final zerosNumbers = List.filled(decimalDigits, '#').join();
    final formatter =
        region == Region.VN
            ? NumberFormat("###,###.$zerosNumbers", "vi_VN")
            : NumberFormat("###,###.$zerosNumbers", "en_US");
    final formattedAmount = formatter.format(this);
    return formattedAmount;
  }
}
