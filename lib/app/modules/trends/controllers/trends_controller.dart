// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/base/infinite_list/base_infinite_list_controller.dart';
import 'package:d3_wallet/data/base_response_object.dart';
import 'package:d3_wallet/data/bean/request/coin_market_request_object/coin_market_request_object.dart';
import 'package:d3_wallet/data/bean/response/coin_market_res_object/coin_market_res_object.dart';
import 'package:d3_wallet/data/remote/api_error.dart';
import 'package:d3_wallet/data/repositories/coin_market_repository.dart';
import 'package:d3_wallet/data/result.dart';
import 'package:fimber/fimber.dart';
import 'package:get/get.dart';

import '../../home/constants/nav_ids.dart';
import '../../home/controllers/home_controller.dart';

class TrendsController extends BaseInfiniteListController<CoinMarketResObject> {
  final _allLoadedItems = <CoinMarketResObject?>[];
  final searchKeyword = "".obs;
  final isSearchFocused = false.obs;
  final searchHistory = <String>["Bitcoin", "Ethereum", "Solana"].obs; // Mock history

  @override
  void onInit() {
    super.onInit();
    Fimber.d("onInit()");
    ever(HomeController.to.rootTabTapEvent, (navId) {
      if (navId == NavIds.trends) {
        scrollToTop();
        fetchData(isRefresh: true);
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    Fimber.d("onReady()");
  }

  @override
  void onClose() {
    super.onClose();
    Fimber.d("onClose()");
  }

  @override
  List<CoinMarketResObject?>? prepareDataBeforeAdding({
    List<CoinMarketResObject?>? allItems,
    List<CoinMarketResObject?>? newItems,
  }) {
    if (pageNumber == 1) {
      _allLoadedItems.clear();
    }
    _allLoadedItems.addAll(newItems ?? []);

    return _filterItemsLocally(_allLoadedItems);
  }

  void onSearchChanged(String value) {
    searchKeyword.value = value;
    items.clear();
    items.addAll(_filterItemsLocally(_allLoadedItems));
    hasNoData.value = items.isEmpty;
    update();
  }

  void onMicTap() {
    Fimber.d("onMicTap()");
    // future: trigger voice search
  }

  void onHistoryTap(String value) {
    Fimber.d("onHistoryTap(value: $value)");
    onSearchChanged(value);
  }

  List<CoinMarketResObject?> _filterItemsLocally(List<CoinMarketResObject?> source) {
    if (searchKeyword.isEmpty) {
      return source;
    }
    final query = searchKeyword.value.toLowerCase();
    return source.where((coin) {
      final symbol = coin?.symbol?.toLowerCase() ?? "";
      final name = coin?.name?.toLowerCase() ?? "";
      return symbol.contains(query) || name.contains(query);
    }).toList();
  }

  @override
  Future<Result<BaseResponseObject<List<CoinMarketResObject?>?>, ApiError>>
  retrieveDataFromService(int? pageNumber) {
    Fimber.d("retrieveDataFromService(pageNumber: $pageNumber)");
    return Get.find<CoinMarketRepository>().getCoins(
      CoinMarketRequestObject(
        start: ((pageNumber ?? 1) - 1) * defaultItemsPerPageCount + 1,
        limit: defaultItemsPerPageCount,
      ),
    );
  }
}
