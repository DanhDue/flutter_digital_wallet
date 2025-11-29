// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

class AppUri {
  // base url
  // static const String baseUrl = "http://10.0.2.2/solana/";
  // static const String baseUrl = "https://driving-sweeping-joey.ngrok-free.app/";

  // receiveTimeout
  static const int receiveTimeout = 30000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  static const String users = 'users';
  static const String wallets = 'wallets';
  static const String tokens = 'tokens';
  static const String transactions = 'transactions';
  static const String healthz = 'healthz';
}

class UriPaths {
  static const String api = "api";
  static const String apiVersion = "v1";
  static const String mnemonics = "/mnemonics";
  static const String address = "/{address}";
  static const String airdrop = "/airdrop";
  static const String account = "/account";
  static const String accounts = "/accounts";
  static const String transfer = "/transfer";
  static const String token_mint = "/{mint_address}";
}

class UriPathParameters {
  static const String address = "/{address}";
  static const String signature = "/{signature}";
}
