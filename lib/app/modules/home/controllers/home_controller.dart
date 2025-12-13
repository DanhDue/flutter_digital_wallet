// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/base/networking_mixin.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class HomeController extends BaseController with NetworkingMixin {
  static HomeController get to => Get.find();

  final currentTabIndex = 0.obs;

  // For double-back-to-exit functionality
  DateTime? _lastBackPressTime;
  static const _exitTimeWindow = Duration(seconds: 2);

  @override
  void onInit() {
    super.onInit();
    Fimber.d("HomeController onInit()");
    // Register back button interceptor to handle back before nested navigators
    BackButtonInterceptor.add(_onBackPressed, zIndex: 1, name: 'home');
  }

  @override
  void onReady() async {
    super.onReady();
    Fimber.d("HomeController onReady()");
  }

  @override
  void onClose() {
    BackButtonInterceptor.removeByName('home');
    super.onClose();
    Fimber.d("HomeController onClose()");
  }

  void changeTab(int index) {
    currentTabIndex.value = index;
  }

  /// Get the current navigator ID
  int get currentNavId => currentTabIndex.value;

  /// Back button interceptor callback
  /// Returns true to consume the event (handled), false to let system handle it
  bool _onBackPressed(bool stopDefaultButtonEvent, RouteInfo info) {
    Fimber.d("Back button intercepted");

    // First, check if we can pop from the root/global navigator
    // This handles cases like Login screen pushed on top of Home
    if (Get.key.currentState != null && Get.key.currentState!.canPop()) {
      Fimber.d("Popping root navigator (global screen)");
      Get.back(); // Pop from root navigator
      return true; // Consumed
    }

    // Try to pop from the current tab's nested navigator using GetX
    final nestedKey = Get.nestedKey(currentNavId);
    if (nestedKey?.currentState != null && nestedKey!.currentState!.canPop()) {
      Fimber.d("Popping nested navigator");
      Get.back(id: currentNavId);
      return true; // Consumed
    }

    // At root of tab - implement double-back-to-exit
    final now = DateTime.now();
    if (_lastBackPressTime == null || now.difference(_lastBackPressTime!) > _exitTimeWindow) {
      _lastBackPressTime = now;
      Fimber.d("Showing exit toast");
      SmartDialog.showToast("Press back again to exit");
      return true; // Consumed, don't exit
    }

    // User pressed back twice within time window - exit app
    Fimber.d("Exiting app");
    SystemNavigator.pop();
    return true; // We handled the exit
  }

  /// Handle back button press (for PopScope fallback)
  Future<bool> handleBackPress() async {
    Fimber.d("handleBackPress() called");

    // Try to pop from nested navigator using GetX
    final nestedKey = Get.nestedKey(currentNavId);
    if (nestedKey?.currentState != null && nestedKey!.currentState!.canPop()) {
      Fimber.d("Popping from nested navigator");
      Get.back(id: currentNavId);
      return false; // Handled, don't exit
    }

    // At root of tab - implement double-back-to-exit
    final now = DateTime.now();
    if (_lastBackPressTime == null || now.difference(_lastBackPressTime!) > _exitTimeWindow) {
      _lastBackPressTime = now;
      Fimber.d("First back press - showing toast");
      SmartDialog.showToast("Press back again to exit");
      return false;
    }

    // User pressed back twice - exit app
    Fimber.d("Second back press - exiting app");
    SystemNavigator.pop();
    return true;
  }
}
