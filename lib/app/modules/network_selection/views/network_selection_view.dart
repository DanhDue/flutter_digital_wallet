// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/data/bean/response/network_object/network_object.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/network_selection_controller.dart';

class NetworkSelectionView extends StatefulWidget {
  const NetworkSelectionView({super.key, this.selectedNetwork});

  final NetworkObject? selectedNetwork;

  @override
  State<NetworkSelectionView> createState() => _NetworkSelectionViewState();
}

class _NetworkSelectionViewState extends State<NetworkSelectionView> {
  final controller = Get.put(NetworkSelectionController(), permanent: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NetworkSelectionView'), centerTitle: true),
      body: const Center(
        child: Text('NetworkSelectionView is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
