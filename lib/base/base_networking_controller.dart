// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'base_controller.dart';
import 'base_networking_mixin.dart';

/// A base controller with networking capabilities.
///
/// This class combines [BaseController] with [BaseNetworkingMixin] for
/// controllers that need to make API calls.
///
/// For more flexibility, you can also apply [BaseNetworkingMixin] directly
/// to your controller:
/// ```dart
/// class MyController extends BaseController<MyState> with BaseNetworkingMixin<MyState> { }
/// ```
abstract class BaseNetworkingController<T> extends BaseController<T> with BaseNetworkingMixin<T> {}
