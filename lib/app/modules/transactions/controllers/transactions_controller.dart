// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:collection/collection.dart';
import 'package:d3_wallet/base/infinite_list/base_infinite_list_controller.dart';
import 'package:d3_wallet/data/base_response_object.dart';
import 'package:d3_wallet/data/bean/response/transaction_response_object/transaction_response_object.dart';
import 'package:d3_wallet/data/remote/api_error.dart';
import 'package:d3_wallet/data/repositories/transaction_repository.dart';
import 'package:d3_wallet/data/result.dart';
import 'package:fimber/fimber.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:get/state_manager.dart';

class TransactionsController extends BaseInfiniteListController<TransactionResponseObject> {
  final transactionRepo = Get.find<TransactionRepository>();

  String? lastDayInTheList;

  @override
  void onInit() {
    super.onInit();
    Fimber.d("onInit()");
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
  Future<Result<BaseResponseObject<List<TransactionResponseObject?>?>, ApiError>>
  retrieveDataFromService(int? pageNumber) => transactionRepo.getTransactionByOwner(
    'CRG9hpv6WpMHhiNZKF9XSjTnfS9SavtTJqhTRc3xG4GZ',
    limit: 3,
    before: items.lastOrNull?.overview?.signature?.firstOrNull,
  );

  @override
  List<TransactionResponseObject?>? prepareDataBeforeAdding({
    List<TransactionResponseObject?>? allItems,
    List<TransactionResponseObject?>? newItems,
  }) {
    if (allItems?.isBlank == true) lastDayInTheList = null;
    final result = <TransactionResponseObject?>[];
    result.addAll(allItems ?? []);

    // group new items follow by day
    final groupedItems = groupBy(
      newItems ?? [],
      (p0) => p0?.overview?.timestamp?.yMMMMd,
    ).entries.toList();

    // sort grouped items by date
    groupedItems.sort(
      (a, b) => (b.value.firstOrNull?.overview?.timestamp?.millisecondsSinceEpoch ?? 0).compareTo(
        a.value.firstOrNull?.overview?.timestamp?.millisecondsSinceEpoch ?? 0,
      ),
    );

    // add all items to result if it's group is added.
    if (groupedItems.first.key == lastDayInTheList) {
      if (result.isNotEmpty == true) result.last = result.last?.copyWith(isLast: false);
      result.addAll(groupedItems.first.value.map((e) => e as TransactionResponseObject?));
      lastDayInTheList = groupedItems.last.key;
      groupedItems.removeAt(0);
      result.last = result.last?.copyWith(isLast: true);
    } else {
      lastDayInTheList = groupedItems.last.key;
    }

    for (var groupedNotifications in groupedItems) {
      // add the group title item.
      result.add(
        TransactionResponseObject(
          isLabel: true,
          overview:
              (groupedNotifications.value.firstOrNull as TransactionResponseObject?)?.overview,
        ),
      );

      groupedNotifications.value.last =
          (groupedNotifications.value.last as TransactionResponseObject?)?.copyWith(isLast: true);

      // add all notifications follow by it's group.
      result.addAll(groupedNotifications.value.map((e) => e as TransactionResponseObject?));
    }
    return result;
  }
}
