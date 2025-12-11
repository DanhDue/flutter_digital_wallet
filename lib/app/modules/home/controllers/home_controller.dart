// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/base/networking_mixin.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class HomeController extends BaseController with NetworkingMixin {
  final currentTabIndex = 0.obs;

  // Global keys for each tab's navigator
  final myWalletsNavKey = GlobalKey<NavigatorState>();
  final transactionsNavKey = GlobalKey<NavigatorState>();
  final qrScanningNavKey = GlobalKey<NavigatorState>();
  final trendsNavKey = GlobalKey<NavigatorState>();
  final profileNavKey = GlobalKey<NavigatorState>();

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

  /// Get the navigator key for the current tab
  GlobalKey<NavigatorState> get currentNavKey {
    switch (currentTabIndex.value) {
      case 0:
        return myWalletsNavKey;
      case 1:
        return transactionsNavKey;
      case 2:
        return qrScanningNavKey;
      case 3:
        return trendsNavKey;
      case 4:
        return profileNavKey;
      default:
        return myWalletsNavKey;
    }
  }

  /// Back button interceptor callback
  /// Returns true to consume the event (handled), false to let system handle it
  bool _onBackPressed(bool stopDefaultButtonEvent, RouteInfo info) {
    Fimber.d("Back button intercepted");

    // First, check if the current tab's nested navigator can pop
    final navState = currentNavKey.currentState;
    if (navState != null && navState.canPop()) {
      Fimber.d("Popping nested navigator");
      navState.pop();
      return true; // Consumed, don't let system handle it
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
    // First, check if the current tab's nested navigator can pop
    final navState = currentNavKey.currentState;
    if (navState != null && navState.canPop()) {
      navState.pop();
      return false; // Handled, don't exit
    }

    // At root of tab - implement double-back-to-exit
    final now = DateTime.now();
    if (_lastBackPressTime == null || now.difference(_lastBackPressTime!) > _exitTimeWindow) {
      _lastBackPressTime = now;
      SmartDialog.showToast("Press back again to exit");
      return false;
    }
    return true;
  }
}
