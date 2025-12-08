// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';

abstract class SelectedAccountStorage {
  Future<WalletResponseObject?> retrieveSelectedWallet();
  Future createOrReplaceSelectedWallet(WalletResponseObject? selectedWallet);
  Future clear();
}
