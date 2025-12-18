// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'dart:ui';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:d3_wallet/data/remote/app_uri.dart';
import 'package:d3_wallet/utils/constants.dart';
import 'package:d3_wallet/utils/date_time_utils.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:dart_helper_utils/dart_helper_utils.dart';
import 'package:fimber/fimber.dart';
import 'package:get/get_utils/get_utils.dart';

extension StringExt on String? {
  String? formatMnemonicIntoThreeLines() {
    if (this == null || this!.isEmpty) return null;
    final words = this!.split(' ');
    if (words.length != 12) return this;

    return '${words.sublist(0, 4).join(' ')}\n'
        '${words.sublist(4, 8).join(' ')}\n'
        '${words.sublist(8, 12).join(' ')}';
  }

  bool containsOnlyAlphaNumeric() {
    if (this == null || this!.isEmpty) return false;
    return RegExp(r'^[0-9]+$').hasMatch(this!);
  }

  bool containsOnlyAlphabet() {
    if (this == null || this!.isEmpty) return false;
    return RegExp(r'^[a-zA-Z]+$').hasMatch(this!);
  }

  bool containsSpecialCharacter() {
    if (this == null || this!.isEmpty) return false;
    return RegExp(r'[^a-zA-Z0-9]').hasMatch(this!);
  }

  // Checks if the string contains any digit
  bool containsDigit() => this?.contains(RegExp(r'\d')) ?? false;

  // Checks if the string contains any uppercase letter
  bool containsUppercase() => this?.contains(RegExp(r'[A-Z]')) ?? false;

  // Checks if the string contains any lowercase letter
  bool containsLowercase() => this?.contains(RegExp(r'[a-z]')) ?? false;

  /// Formats the wallet address for display by showing the first 7 and last 4 characters
  /// Returns a formatted string in the format "7KSS...k9V1"
  /// If address is null or empty, returns null
  /// If address is shorter than 11 characters, returns the full address
  String? formatWalletAddress() {
    if (this == null || this!.isEmpty) {
      return null;
    }
    if (this!.length < 11) {
      return this;
    }
    return "${this!.substring(0, 7)}...${this!.substring(this!.length - 4)}";
  }

  String retrieveZeroValue() => this == Region.VN ? "0,00" : "0.00";

  String? retrieveWalletAddress() {
    if (isNotBlank()) {
      final prefix = this?.substring(0, 4);
      final suffix = this?.substring((this?.length ?? 5) - 5);
      return "$prefix...$suffix";
    } else {
      return null;
    }
  }

  bool isNotBlank() => this != null && this?.trim().isNotEmpty == true;

  Color? toColor() {
    var hexColor = this?.replaceAll("#", "");
    if (hexColor?.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor?.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    return null;
  }

  bool isValidEmail() {
    if (this == null || DHUNullSafeStringExtensions(this)?.isBlank == true) {
      return false;
    }
    return RegExp(Constants.emailValidateReg).hasMatch(this ?? '');
  }

  bool isValidPhoneNumber() {
    if (this == null || DHUNullSafeStringExtensions(this)?.isBlank == true) {
      return false;
    }
    return RegExp(Constants.phoneValidateReg).hasMatch(this ?? '');
  }

  bool isValidPassword() {
    if (this == null || DHUNullSafeStringExtensions(this)?.isBlank == true) {
      return false;
    }
    return RegExp(Constants.passValidateReg).hasMatch(this ?? '');
  }

  bool isBirthDayFormat({String? dateTimeFormat}) {
    if (this == null || DHUNullSafeStringExtensions(this)?.isBlank == true) {
      return false;
    }
    try {
      DateFormat(dateTimeFormat ?? DateTimeUtils.yMd).parse(this ?? '');
      return true;
    } on Exception catch (e) {
      e.printError();
      Fimber.e(e.toString());
      return false;
    }
  }

  String? buildAppUri() {
    if (this == null || DHUNullSafeStringExtensions(this)?.isBlank == true) {
      return null;
    }
    try {
      if (this?.contains(AppUri.healthz) == true) return Uri.parse(this!).toString();
      final uri = Uri.parse("${UriPaths.api}/${UriPaths.apiVersion}/$this");
      return uri.toString();
    } on Exception catch (e) {
      e.printError();
      Fimber.e(e.toString());
      return null;
    }
  }

  String toNoAccentVietnamese() {
    var result = this ?? '';
    result = result.replaceAll(RegExp(r'[àáạảãâầấậẩẫăằắặẳẵ]'), 'a');
    result = result.replaceAll(RegExp(r'[ÀÁẠẢÃĂẰẮẶẲẴÂẦẤẬẨẪ]'), 'A');
    result = result.replaceAll(RegExp(r'[èéẹẻẽêềếệểễ]'), 'e');
    result = result.replaceAll(RegExp(r'[ÈÉẸẺẼÊỀẾỆỂỄ]'), 'E');
    result = result.replaceAll(RegExp(r'[òóọỏõôồốộổỗơờớợởỡ]'), 'o');
    result = result.replaceAll(RegExp(r'[ÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠ]'), 'O');
    result = result.replaceAll(RegExp(r'[ìíịỉĩ]'), 'i');
    result = result.replaceAll(RegExp(r'[ÌÍỊỈĨ]'), 'I');
    result = result.replaceAll(RegExp(r'[ùúụủũưừứựửữ]'), 'u');
    result = result.replaceAll(RegExp(r'[ƯỪỨỰỬỮÙÚỤỦŨ]'), 'U');
    result = result.replaceAll(RegExp(r'[ỳýỵỷỹ]'), 'y');
    result = result.replaceAll(RegExp(r'[ỲÝỴỶỸ]'), 'Y');
    result = result.replaceAll(RegExp(r'[Đ]'), 'D');
    result = result.replaceAll(RegExp(r'[đ]'), 'd');
    return result;
  }

  String reformatUSDolar() {
    return "${this?.replaceAll("\$", "").trim()} \$";
  }

  String clearUSDolarCharacter() {
    return "${this?.replaceAll("\$", "").trim()}";
  }

  String? buildCoinPrice(String symbol, {int? decimalDigits = 6}) {
    if (this == null) return null;
    return "${CurrencyTextInputFormatter.simpleCurrency(decimalDigits: decimalDigits).formatDouble((this?.toDoubleOrNull() ?? 0)).replaceAll("\$", "")} $symbol";
  }
}
