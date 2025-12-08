// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/bean/response/token_account_object/token_account_object.dart';

abstract class TokenAccountStorage {
  Future<List<TokenAccountObject?>?> retrieveTokenAccounts(String ownerAddress);
  Future addTokenAccount(String ownerAddress, TokenAccountObject? tokenAccount);
  Future removeTokenAccount(String ownerAddress, TokenAccountObject? tokenAccount);
  Future clear(String ownerAddress);
}
