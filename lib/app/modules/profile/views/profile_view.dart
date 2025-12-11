import 'package:d3_wallet/base/base_view.dart';
import 'package:flutter/material.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends BaseView<ProfileController> {
  ProfileView({super.key});
  @override
  Widget onCreateViews(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ProfileView'), centerTitle: true),
      body: const Center(child: Text('ProfileView is working', style: TextStyle(fontSize: 20))),
    );
  }
}
