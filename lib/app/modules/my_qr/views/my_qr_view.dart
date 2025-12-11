// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/my_qr_controller.dart';

class MyQrView extends GetView<MyQrController> {
  const MyQrView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MyQrView'), centerTitle: true),
      body: const Center(child: Text('MyQrView is working', style: TextStyle(fontSize: 20))),
    );
  }
}
