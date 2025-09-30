// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/data/base_response_object.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/data/remote/api_error.dart';
import 'package:d3_wallet/data/remote/wallet_client/wallet_client.dart';
import 'package:d3_wallet/data/repositories/safe_call_api_mixin.dart';
import 'package:d3_wallet/data/repositories/wallet_repository.dart';
import 'package:d3_wallet/data/result.dart';
import 'package:get/get.dart';

class WalletRepositoryImpl extends WalletRepository with SafeCallApiMixin {
  final walletClient = Get.find<WalletClient>();
  @override
  Future<Result<BaseResponseObject<WalletResponseObject>?, ApiError>> validateWallet(
    String walletAddress,
  ) => safeApiCall(() => walletClient.validate(walletAddress));
}
