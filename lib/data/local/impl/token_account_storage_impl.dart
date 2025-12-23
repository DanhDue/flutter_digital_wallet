// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/bean/response/token_account_object/token_account_object.dart';
import 'package:d3_wallet/data/local/storage_keys.dart';
import 'package:d3_wallet/data/local/token_account_storage.dart';
import 'package:d3_wallet/data/repositories/secure_keys.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive_ce.dart';

class TokenAccountStorageImpl extends TokenAccountStorage {
  final _secureKeys = Get.find<SecureKeys>();
  @override
  Future addTokenAccount(String ownerAddress, TokenAccountObject? tokenAccount) async {
    var encryptedBox = await openTokenAccountBox(ownerAddress);
    encryptedBox.add(tokenAccount);
  }

  @override
  Future removeTokenAccount(String ownerAddress, TokenAccountObject? tokenAccount) async {
    var encryptedBox = await openTokenAccountBox(ownerAddress);
    encryptedBox.delete(tokenAccount);
  }

  @override
  Future<List<TokenAccountObject?>?> retrieveTokenAccounts(String ownerAddress) async {
    var encryptedBox = await openTokenAccountBox(ownerAddress);
    return encryptedBox.values.toList();
  }

  @override
  Future clear(String ownerAddress) async {
    final tokenAccountBox = await openTokenAccountBox(ownerAddress);
    await tokenAccountBox.clear();
  }

  Future<Box<TokenAccountObject?>> openTokenAccountBox(String ownerAddress) async {
    return await Hive.openBox<TokenAccountObject?>(
      ownerAddress,
      encryptionCipher: await _secureKeys.retrieveHiveAesCipher(StorageKeys.tokenAccountBoxName),
    );
  }
}
