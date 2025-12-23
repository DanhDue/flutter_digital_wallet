// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:d3_wallet/utils/constants.dart';
import 'package:d3_wallet/utils/extensions/string_ext.dart';
import 'package:dart_helper_utils/dart_helper_utils.dart';

extension DoubleExt on double? {
  String shrinkAndReformatUSDolar({int fractionDigits = 2}) {
    return "${this?.shrinkCurrencyAsFixed(fractionDigits: fractionDigits)?.reformatUSDolar()}";
  }

  String shrinkAndReformat({int fractionDigits = 2}) {
    return "${this?.shrinkCurrencyAsFixed(fractionDigits: fractionDigits)?.clearUSDolarCharacter()}";
  }

  String? shrinkCurrencyAsFixed({int fractionDigits = 2}) {
    if ((this ?? 0.0) >= 1000000000000) {
      return "${CurrencyTextInputFormatter.simpleCurrency(decimalDigits: fractionDigits).formatDouble((this ?? 0.0) / 1000000000)}T";
    }
    if ((this ?? 0.0) >= 1000000000) {
      return "${CurrencyTextInputFormatter.simpleCurrency(decimalDigits: fractionDigits).formatDouble((this ?? 0.0) / 1000000000)}B";
    }
    if ((this ?? 0.0) >= 1000000) {
      return "${CurrencyTextInputFormatter.simpleCurrency(decimalDigits: fractionDigits).formatDouble((this ?? 0.0) / 1000000)}M";
    }
    return CurrencyTextInputFormatter.simpleCurrency(
      decimalDigits: fractionDigits,
    ).formatDouble(this ?? 0.0);
  }

  String? shrinkTokenValue({int fractionDigits = 2}) {
    if ((this ?? 0.0) >= 1000000000000) {
      return "${((this ?? 0.0) / 1000000000).toStringAsFixed(fractionDigits)}T";
    }
    if ((this ?? 0.0) >= 1000000000) {
      return "${((this ?? 0.0) / 1000000000).toStringAsFixed(fractionDigits)}B";
    }
    if ((this ?? 0.0) >= 1000000) {
      return "${((this ?? 0.0) / 1000000).toStringAsFixed(fractionDigits)}M";
    }
    return (this ?? 0.0).toStringAsFixed(fractionDigits);
  }

  String? retrieveDoubleAmount(String region, {int decimalDigits = 3}) {
    final zerosNumbers = List.filled(decimalDigits, '#').join();
    final formatter = region == Region.VN
        ? NumberFormat("###,###.$zerosNumbers", "vi_VN")
        : NumberFormat("###,###.$zerosNumbers", "en_US");
    final formattedAmount = formatter.format(this);
    return formattedAmount;
  }
}
