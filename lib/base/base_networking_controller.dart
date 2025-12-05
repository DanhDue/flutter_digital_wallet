// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/data/remote/api_error.dart';
import 'package:d3_wallet/data/result.dart';
import 'package:get/get.dart';

import 'base_controller.dart';

abstract class BaseNetworkingController<T> extends BaseController<T> {
  Future<void> callApi<D>(
    Future<Result<D, ApiError>> apiCall, {
    required void Function(D data) onSuccess,
    void Function(ApiError error)? onError,
  }) async {
    change(null, status: RxStatus.loading());
    final result = await apiCall;
    switch (result) {
      case Success(data: final data):
        onSuccess(data);
        change(state, status: RxStatus.success());
      case Failure(error: final error):
        if (onError != null) {
          onError(error);
        }
        change(null, status: RxStatus.error(error.message));
    }
  }
}
