// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/data/local/selected_account_storage.dart';
import 'package:d3_wallet/data/local/storage_keys.dart';
import 'package:d3_wallet/data/repositories/secure_keys.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SelectedAccountStorageImpl extends SelectedAccountStorage {
  final _secureKeys = Get.find<SecureKeys>();

  @override
  Future<WalletResponseObject?> retrieveSelectedWallet() async {
    var encryptedBox = await openYourWalletBox();
    return encryptedBox.get(StorageKeys.selectedWalletKey);
  }

  @override
  Future createOrReplaceSelectedWallet(WalletResponseObject? selectedWallet) async {
    var encryptedBox = await openYourWalletBox();
    encryptedBox.put(StorageKeys.selectedWalletKey, selectedWallet);
  }

  @override
  Future clear() async {
    final selectedAccountBox = await openYourWalletBox();
    await selectedAccountBox.clear();
  }

  Future<Box<WalletResponseObject?>> openYourWalletBox() async {
    return await Hive.openBox<WalletResponseObject?>(
      StorageKeys.selectedWalletBoxName,
      encryptionCipher: await _secureKeys.retrieveHiveAesCipher(StorageKeys.selectedWalletBoxName),
    );
  }
}
