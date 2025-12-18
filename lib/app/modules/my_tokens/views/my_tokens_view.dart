// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/base/base_networking_view.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../controllers/my_tokens_controller.dart';

class MyTokensView extends BaseNetworkingView<MyTokensController> {
  MyTokensView({super.key});

  @override
  Widget buildBody(BuildContext context, state) {
    // state = null => initial state
    if (state == null) {
      controller.fetchTokenAccounts(
        WalletResponseObject(address: "6LXFznMNbFKcJZbF3azQTnd3SaVf2kCnqF4B4NsH4u3R"),
      );
    }
    return Obx(
      () => Scaffold(
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              Center(child: Text("Results: ${controller.tokens.value.length}")),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.tokens.value.length,
                  itemBuilder: (context, index) {
                    final token = controller.tokens.value[index];
                    return ListTile(
                      title: Text(token?.address ?? ""),
                      subtitle: Text(token?.amount.toString() ?? ""),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
