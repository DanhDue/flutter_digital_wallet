// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

class NavigationArguments {
  static const qr = QrNavigationArguments();
  static const isNewAddition = "isNewAddition";
  static const selectedWallet = "selectedWallet";
  static const savedWallet = "savedWallet";
  static const selectedNetwork = "selectedNetwork";
  static const coinMarketInfo = "coinMarketInfo";
  static const slippage = "slippage";
  static const selectedToken = "selectedToken";
  static const selectedDestToken = "selectedDestToken";
  static const estimatedReceivedCoin = "estimatedReceivedCoin";
  static const selectedWhirlpool = "selectedWhirlpool";
  static const swapResult = "swapResult";
  static const appConfigurations = "appConfigurations";
  static const networkFee = "networkFee";
  static const wallet = "wallet";
  static const walletIndex = "walletIndex";
  static const fromQRScanner = "fromQRScanner";
  static const srcWallet = "srcWallet";
  static const destWallet = "destWallet";
  static const amount = "amount";
  static const mintToken = "mintToken";
  static const walletAddress = "walletAddress";
}

class QrNavigationArguments {
  const QrNavigationArguments();
  final showFullScreen = "showFullScreen";
}

enum AccountActions {
  editAccountName,
  bscScan,
  shareLink,
  showPassKey,
  showMnemonics,
  showSecureQuestions,
  showFirstSecureQuestion,
  showSecondSecureQuestion,
}
