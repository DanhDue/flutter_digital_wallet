// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

/// Navigator IDs for nested navigation with GetX
class NavIds {
  // Global/Root navigator ID for app-level navigation (splash -> login -> home)
  // Use null or don't specify id parameter for global navigation
  // Example: Get.toNamed(Routes.LOGIN) or Get.toNamed(Routes.HOME)

  // Tab-level nested navigator IDs (for navigation within each tab)
  static const int wallet = 0;
  static const int transactions = 1;
  static const int qr = 2;
  static const int trends = 3;
  static const int profile = 4;
}
