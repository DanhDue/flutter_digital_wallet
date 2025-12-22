// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/data/bean/response/network_object/network_object.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/utils/constants.dart';
import 'package:d3_wallet/utils/extensions/string_ext.dart';
import 'package:dart_helper_utils/dart_helper_utils.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class NetworkSelectionController extends BaseController {
  final selectedNetwork =
      NetworkObject(id: NetworkIds.ALL, name: LocaleKeys.allNetworks.tr, logo: "").obs;
  final lstNetworks = <NetworkObject>[].obs;
  final RxList<NetworkObject> filteredNetworks = <NetworkObject>[].obs;
  late TextEditingController? filterTextEditingController;
  late FocusNode? filterTextFocusNode;
  final filterTextIsFocus = false.obs;
  final showFilterTextClearIcon = false.obs;
  String? networkName;

  @override
  void onInit() {
    super.onInit();
    Fimber.d("onInit()");
    filterTextEditingController = TextEditingController();
    filterTextFocusNode = FocusNode();
    lstNetworks.addAll([
      NetworkObject(id: NetworkIds.ALL, name: LocaleKeys.allNetworks.tr, logo: ""),
      NetworkObject(
        id: NetworkIds.SOLANA,
        name: "Solana Mainnet Beta",
        logo: "https://s2.coinmarketcap.com/static/img/coins/200x200/5426.png",
      ),
    ]);
    filteredNetworks.addAll(lstNetworks);
  }

  @override
  void onReady() {
    super.onReady();
    Fimber.d("onReady()");
    _handleTokenNameTextFieldFocus();
  }

  @override
  void onClose() {
    super.onClose();
    Fimber.d("onClose()");
    filterTextEditingController?.dispose();
    filterTextFocusNode?.dispose();
  }

  _handleTokenNameTextFieldFocus() {
    Fimber.d("_handleTokenNameTextFieldFocus");
    filterTextFocusNode?.addListener(() {
      if (filterTextFocusNode?.hasFocus == true) {
        filterTextIsFocus.value = true;
        if (networkName?.isNotEmpty == true) showFilterTextClearIcon.value = true;
      } else {
        _validateNetworkName();
        filterTextIsFocus.value = false;
        if (networkName?.isNotEmpty == true) {
          showFilterTextClearIcon.value = true;
        } else {
          showFilterTextClearIcon.value = false;
        }
      }
    });
  }

  Future<void> _validateNetworkName() async {
    Fimber.d("_validateFirst()");
  }

  void setInputs(NetworkObject? selectedNetwork) {
    Fimber.d("setInputs(selectedNetwork: ${selectedNetwork?.toJson().encodedJsonString})");
    this.selectedNetwork.value =
        ((StringExt(selectedNetwork?.name)?.isNotBlank() == true)
            ? selectedNetwork
            : NetworkObject(id: NetworkIds.ALL, name: LocaleKeys.allNetworks.tr, logo: ""))!;
  }

  void updateSelectedNetwork(NetworkObject network) {
    selectedNetwork.value = network;
  }

  void filterNetworksByName(String query) async {
    if (query.isEmpty) {
      filteredNetworks.value = lstNetworks;
      return;
    }
    networkName = query;
    showFilterTextClearIcon.value = true;

    filteredNetworks.value =
        lstNetworks
            .where((network) => network.name?.toLowerCase().contains(query.toLowerCase()) == true)
            .toList();
  }

  void clearFilterredText() {
    Fimber.d("clearFilterredText()");
    filteredNetworks.value = lstNetworks;
    filterTextEditingController?.text = "";
    networkName = '';
    showFilterTextClearIcon.value = false;
  }

  void reset() {
    Fimber.d("reset()");
    filteredNetworks.value = lstNetworks;
    filterTextEditingController?.text = "";
    networkName = null;
    showFilterTextClearIcon.value = false;
  }
}
