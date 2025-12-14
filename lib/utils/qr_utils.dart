// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/utils/base64_utils.dart';
import 'package:fimber/fimber.dart';

class QrUtils {
  QrUtils._();
  static final QrUtils instance = QrUtils._();

  static final mnemonic = "mnemonic";
  static final secretKey = "secretKey";
  static final walletAddress = "walletAddress";

  static final mnemonicUrl = "https://zeno.app.link/walletImport?$mnemonic=";
  static final secretKeyUrl = "https://zeno.app.link/walletImport?$secretKey=";
  static final transferUrl = "https://zeno.app.link/transfer?$walletAddress=";

  String retrieveMemonicQRData(String mnemonic) {
    final qrUrl = "$mnemonicUrl$mnemonic";
    return Base64Utils().encode(qrUrl);
  }

  String? retrieveMnemonicFromQr(String scannedData) {
    Fimber.d("retrieveMnemonicFromQr(scannedData: $scannedData)");
    if (!Base64Utils().isBase64(scannedData)) return null;
    final decoded = Base64Utils().decode(scannedData);
    if (decoded.contains(mnemonicUrl) == true) {
      final uri = Uri.parse(decoded);
      final queryParameters = uri.queryParameters;
      if (queryParameters.isNotEmpty) {
        return queryParameters[mnemonic];
      }
      return null;
    }
    return null;
  }

  String retrieveSecretKeyQRData(String mnemonic) {
    final qrUrl = "$secretKeyUrl$mnemonic";
    return Base64Utils().encode(qrUrl);
  }

  String? retrieveSecretKeyFromQr(String scannedData) {
    Fimber.d("retrieveSecretKeyFromQr(scannedData: $scannedData)");
    if (!Base64Utils().isBase64(scannedData)) return null;
    final decoded = Base64Utils().decode(scannedData);
    if (decoded.contains(secretKeyUrl) == true) {
      final uri = Uri.parse(decoded);
      final queryParameters = uri.queryParameters;
      if (queryParameters.isNotEmpty) {
        return queryParameters[secretKey];
      }
      return null;
    }
    return null;
  }

  String retrieveTransferQRData(String walletAddress) {
    final qrUrl = "$transferUrl$walletAddress";
    return Base64Utils().encode(qrUrl);
  }

  String? retrieveWalletAddressFromTransferQr(String scannedData) {
    Fimber.d("retrieveWalletAddressFromQr(scannedData: $scannedData)");
    if (!Base64Utils().isBase64(scannedData)) return null;
    final decoded = Base64Utils().decode(scannedData);
    if (decoded.contains(transferUrl) == true) {
      final uri = Uri.parse(decoded);
      final queryParameters = uri.queryParameters;
      if (queryParameters.isNotEmpty) {
        return queryParameters[walletAddress];
      }
      return null;
    }
    return null;
  }
}
