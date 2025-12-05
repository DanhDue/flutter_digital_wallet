// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'base_controller.dart';
import 'base_view.dart';

abstract class BaseNetworkingView<C extends BaseController> extends BaseView<C> {
  BaseNetworkingView({super.key});

  @override
  Widget onCreateViews(BuildContext context) {
    return controller.obx(
      (state) => buildBody(context, state),
      onLoading: buildLoading(context),
      onError: (error) => buildError(context, error),
      onEmpty: buildEmpty(context),
    );
  }

  @protected
  Widget buildBody(BuildContext context, dynamic state);

  @protected
  Widget buildLoading(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  @protected
  Widget buildError(BuildContext context, String? error) {
    return Center(
      child: Text(error ?? 'An error occurred', style: const TextStyle(color: Colors.red)),
    );
  }

  @protected
  Widget buildEmpty(BuildContext context) {
    return const Center(child: Text('No data available'));
  }
}
