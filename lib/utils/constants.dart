// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'dart:ui';

import 'package:d3_wallet/data/bean/response/mint_token_object/mint_token_object.dart';
import 'package:d3_wallet/data/bean/response/token_account_object/token_account_object.dart';

class Constants {
  static const externalLinks = ExternalLinks();
  static const emailValidateReg =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const phoneValidateReg = r"([\+84|84|0]+(3|5|7|8|9|1[2|6|8|9]))+([0-9]{8})\b";
  // password validation regex: Minimum eight characters, at least one uppercase letter,
  // one lowercase letter, one number and one special character:
  // static const passValidateReg =
  //     r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
  // password validation regex: Minimum six characters, at least one letter, one number and one special character:
  static const passValidateReg = r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{6,}$";
  static const transitionDuration = 250;
  static const transitionBottomUpDuration = 350;
  static const keyboardDismissDuration = 350;
  static const spaceCharacter = " ";
  static const ignoreGenNewWallet = "ignoreGenNewWallet";
  static const walletAddressLength = 44;
  static const bitCoinPrice = 102497000;
  static const solanoPrice = 170.63;
  static const snaptixPrice = 2.68;
  static const secretKeyBytesLength = 64;
  static const tempTokenMint = "AnFUAXRbcFrdoV66ixD7GMnwJeExs3iMUrdmbKDovrY7";
  static const defaultSlippage = 2;
  static const solMintToken = "So11111111111111111111111111111111111111112";
  static const oneMillion = 1_000_000;
  static const oneBillion = 1_000_000_000;

  static const TokenAccountObject solanaTokenAccount = TokenAccountObject(
    mintToken: MintTokenObject(
      name: 'Solana',
      symbol: 'SOL',
      address: 'So11111111111111111111111111111111111111112',
      uri: '',
      logo: 'https://s2.coinmarketcap.com/static/img/coins/200x200/5426.png',
      mintAuthority: '',
    ),
    price: 186.68,
    percentChange24h: 1.52402308,
  );
}

class ExternalLinks {
  const ExternalLinks();
  final String secretRecoveyPhraseDefinition =
      "https://support.metamask.io/start/learn/what-is-a-secret-recovery-phrase-and-how-to-keep-your-crypto-wallet-secure/";
}

class DependencyInjections {
  static const String HEALTHZ = "healthz";
  static const int HEALTHZ_TIMEOUT = 8; // in seconds
}

class AppLocales {
  static const Locale vnVI = Locale("vn", "VI");
  static const Locale enUS = Locale("en", "US");
}

class ToastDuration {
  static const LENGTH_SHORT = Duration(milliseconds: 2000);
  static const LENGTH_LONG = Duration(milliseconds: 3500);
}

class InfiniteList {
  static const int ITEMS_PER_PAGE = 20;
  static const int NEXT_PAGE_THRESHOLD = 10;
}

class TransactionDirection {
  static const String RECEIVED = "RECEIVED";
  static const String SENT = "SENT";
}

class TokenType {
  static const String BITCOIN = "BTC";
  static const String ETHEREUM = "ETH";
  static const String SOLANA = "SOL";
  static const String SNAPTIX = "SCN";
  static const String BINANCE = "BNB";
}

class Region {
  static const VN = "VN";
}

class NetworkIds {
  static const String ALL = "ALL";
  static const String BINANCE = "BIN";
  static const String BITCOIN = "BTC";
  static const String ETHEREUM = "ETH";
  static const String SOLANA = "SOL";
  static const String SAMO = "devSAMO";
}

class AppFlavor {
  static const String PRODUCTION = "prd";
  static const String STAGING = "stg";
  static const String DEVELOPMENT = "dev";
}

enum SwapResult { waiting, fail, success }
