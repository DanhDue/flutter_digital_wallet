// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/base/infinite_list/constant.dart';
import 'package:d3_wallet/data/base_response_object.dart';
import 'package:d3_wallet/data/remote/api_error.dart';
import 'package:d3_wallet/data/result.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';

abstract class BaseInfiniteListController<T> extends BaseController<T> {
  bool? hasMore = false;
  int pageNumber = 1;
  int defaultItemsPerPageCount = InfiniteList.ITEMS_PER_PAGE;
  int nextPageThreshold = InfiniteList.NEXT_PAGE_THRESHOLD;
  var items = List<T?>.empty(growable: true);
  bool? loadMoreError = false;
  GlobalKey? refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  GlobalKey? refreshFromNoData = GlobalKey<RefreshIndicatorState>();
  final scrollController = ScrollController();

  @override
  void onReady() {
    fetchData();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
    Fimber.d("onClose()");
  }

  /// Scrolls the list back to the top with a smooth animation
  void scrollToTop() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> fetchData({
    bool? isLoadMore = false,
    bool? isRefresh = false,
    bool? ignoreShowLoading = false,
  }) async {
    if (isRefresh == true) {
      pageNumber = 1;
    }
    if (pageNumber == 1 && ignoreShowLoading != true) isLoading.value = true;
    if (isLoadMore == true) {
      loadMoreError = false;
      update();
    }
    Fimber.d(
      "fetchData({isLoadMore = $isLoadMore, isRefresh = $isRefresh, pageNumber: $pageNumber})",
    );
    final response = await retrieveDataFromService(pageNumber);
    switch (response) {
      case Success(:final data):
        if (isRefresh == true) items.clear();
        // for the retrieveDatasFromService method.
        // items.addAll(data.map((e) => e?.result));

        // for the retrieveDataFromService method.
        // items.addAll(data.result?.toList() ?? []);
        final newItems = data.data?.toList();
        hasMore = newItems?.length == InfiniteList.ITEMS_PER_PAGE;

        if ((newItems == null || newItems.isEmpty) && pageNumber == 1) {
          hasNoData.value = true;
          isLoading.value = false;
          update();
          return;
        }

        final optimizedItems = prepareDataBeforeAdding(allItems: items, newItems: newItems);
        optimizedItems?.isNotEmpty == true
            ? {items.clear(), items.addAll(optimizedItems ?? [])}
            : {items.addAll(newItems ?? [])};

        if (pageNumber == 1) {
          isError.value = '';
          isLoading.value = false;
        }
        pageNumber = pageNumber + 1;
        hasNoData.value = items.isEmpty == true;
        update();
        break;
      case Failure(:final error):
        Fimber.e(error.toString());
        if (pageNumber == 1) {
          items.clear();
          update();
          isError.value = 'true';
          isLoading.value = false;
        } else {
          loadMoreError = true;
        }
        break;
    }
  }

  // This method is used to prepare the model data list before updating the list view.
  // Example: You need to filter/group/change,.. one or more model items.
  List<T?>? prepareDataBeforeAdding({List<T?>? allItems, List<T?>? newItems}) => null;

  Future<Result<BaseResponseObject<List<T?>?>, ApiError>> retrieveDataFromService(int? pageNumber);
  // Future<Result<List<BaseResponseObject<T?>?>, Exception>> retrieveDatasFromService(
  //     int? pageNumber);
}
