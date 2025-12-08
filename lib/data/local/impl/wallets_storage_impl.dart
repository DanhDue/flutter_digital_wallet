// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/data/local/storage_keys.dart';
import 'package:d3_wallet/data/local/wallets_storage.dart';
import 'package:d3_wallet/data/repositories/secure_keys.dart';
import 'package:dart_helper_utils/dart_helper_utils.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class WalletsStorageImpl extends WalletsStorage {
  final _secureKeys = Get.find<SecureKeys>();

  @override
  Future<List<WalletResponseObject?>?> retrieveYourWallets() async {
    // open the box with the secure key.
    var encryptedBox = await openYourWalletBox();
    return encryptedBox.values.toList();
  }

  @override
  Future addItemToYourWallets(WalletResponseObject? wallet) async {
    // open the box with the secure key.
    var encryptedBox = await openYourWalletBox();
    encryptedBox.add(wallet);
  }

  @override
  Future removeItemToYourWallets(WalletResponseObject? wallet) async {
    // open the box with the secure key.
    var encryptedBox = await openYourWalletBox();
    encryptedBox.delete(wallet);
  }

  @override
  Future updateYourWallets(List<WalletResponseObject?>? wallets) async {
    // open the box with the secure key.
    var encryptedBox = await openYourWalletBox();
    await encryptedBox.clear();
    if (wallets?.isNotEmptyOrNull == true) await encryptedBox.addAll(wallets!);
  }

  @override
  Future clearYourWallets() async {
    final walletBox = await openYourWalletBox();
    await walletBox.clear();
  }

  Future<Box<WalletResponseObject?>> openYourWalletBox() async {
    return await Hive.openBox<WalletResponseObject?>(
      StorageKeys.yourWalletsBoxName,
      encryptionCipher: await _secureKeys.retrieveHiveAesCipher(StorageKeys.yourWalletsBoxName),
    );
  }
}
