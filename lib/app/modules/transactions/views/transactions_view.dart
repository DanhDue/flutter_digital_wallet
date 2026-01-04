// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/app/modules/transactions/bindings/transactions_binding.dart';
import 'package:d3_wallet/base/infinite_list/base_infinite_lis_view_with_binding_creator.dart';
import 'package:d3_wallet/data/bean/response/transaction_response_object/transaction_response_object.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:d3_wallet/utils/constants.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../controllers/transactions_controller.dart';

class TransactionsView
    extends BaseInfiniteListViewWithCreator<TransactionsBinding, TransactionsController> {
  TransactionsView({super.key});

  @override
  Widget? onCreateViews(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appThemes.white,
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            _buildWalletSelector(context),
            const SizedBox(height: 24),
            _buildFilterToggle(context),
            const SizedBox(height: 16),
            Expanded(
              child: Stack(
                children: [
                  Obx(
                    () => Visibility(
                      visible: controller.hasNoData.value != true,
                      child: RefreshIndicator(
                        key: controller.refreshIndicatorKey,
                        onRefresh: () =>
                            controller.fetchData(isRefresh: true, ignoreShowLoading: true),
                        child: GetBuilder<TransactionsController>(
                          builder: (controller) => controller.items.isEmptyOrNull
                              ? const SizedBox.shrink()
                              : buildInfiniteList(),
                        ),
                      ),
                    ),
                  ),
                  Obx(() {
                    return Visibility(
                      visible: controller.isError.value?.isNotBlank == true,
                      child: RefreshIndicator(
                        onRefresh: () =>
                            controller.fetchData(isRefresh: true, ignoreShowLoading: true),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: buildErrorLayout(context),
                          ),
                        ),
                      ),
                    );
                  }),
                  Obx(() {
                    return Visibility(
                      visible: controller.hasNoData.value == true,
                      child: RefreshIndicator(
                        key: controller.refreshFromNoData,
                        onRefresh: () =>
                            controller.fetchData(isRefresh: true, ignoreShowLoading: true),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Padding(
                              padding: const .all(20),
                              child: Stack(
                                children: [Center(child: buildHasNoDataLayout(context))],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  Obx(() {
                    return Visibility(
                      visible: controller.isLoading.value == true,
                      child: Center(
                        child: RepaintBoundary(
                          child: Assets.lotties.sandyLoading.lottie(
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            animate: true,
                            repeat: true,
                            backgroundLoading: true,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletSelector(BuildContext context) {
    return Container(
      padding: const .all(16),
      decoration: BoxDecoration(
        color: context.appThemes.white,
        border: Border(bottom: BorderSide(color: context.appThemes.ink5)),
      ),
      child: Row(
        children: [
          Container(
            padding: const .all(8),
            decoration: BoxDecoration(shape: .circle, color: Colors.orange.withValues(alpha: 0.1)),
            child: const Icon(Icons.currency_bitcoin, color: Colors.orange, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  LocaleKeys.btcWallet.tr,
                  style: context.appThemes.medium16.copyWith(color: context.appThemes.ink100),
                ),
                Text(
                  "US\$53,727.78 USD",
                  style: context.appThemes.regular14.copyWith(color: context.appThemes.ink60),
                ),
              ],
            ),
          ),
          Icon(Icons.keyboard_arrow_down, color: context.appThemes.ink60),
        ],
      ),
    );
  }

  Widget _buildFilterToggle(BuildContext context) {
    return Obx(
      () => Container(
        margin: const .symmetric(horizontal: 20),
        padding: const .all(4),
        decoration: BoxDecoration(color: context.appThemes.ink5, borderRadius: .circular(12)),
        child: Row(
          children: [
            _buildToggleButton(
              context,
              LocaleKeys.transactionsReceived.tr,
              controller.selectedFilterIndex.value == 0,
              () {
                controller.changeFilter(0);
              },
            ),
            _buildToggleButton(
              context,
              LocaleKeys.transactionsSent.tr,
              controller.selectedFilterIndex.value == 1,
              () {
                controller.changeFilter(1);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(
    BuildContext context,
    String title,
    bool isActive,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const .symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? context.appThemes.trueBlue : Colors.transparent,
            borderRadius: .circular(10),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          alignment: .center,
          child: Text(
            title,
            style: context.appThemes.medium16.copyWith(
              color: isActive ? context.appThemes.white : context.appThemes.trueBlue,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildItemViews(BuildContext context, {item, int? index}) {
    if (item is TransactionResponseObject) {
      return _buildItem(context, item, index: index);
    }
    return const SizedBox.shrink();
  }

  _buildItem(BuildContext context, TransactionResponseObject transaction, {int? index}) {
    if (transaction.isLabel == true) return _buildLabel(context, transaction, isFirst: index == 0);

    final isReceived = (transaction.overview?.slot ?? 0) % 2 == 0;
    final dateStr = transaction.overview?.timestamp?.yMMMMd ?? "Jun 28, 2021";
    final amountUsd = isReceived ? "US\$694.69" : "US\$320.00";
    final amountCrypto = isReceived ? "0.021BTC" : "0.010BTC";

    return GestureDetector(
      onTap: () {
        Get.toNamed('/transaction-detail', arguments: transaction);
      },
      child: Container(
        padding: const .symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: context.appThemes.white,
          border: Border(bottom: BorderSide(color: context.appThemes.ink5)),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: .circle,
                color: isReceived ? const Color(0xFFE8F5E9) : const Color(0xFFE3F2FD),
              ),
              child: Icon(
                isReceived ? Icons.arrow_downward : Icons.arrow_upward,
                color: isReceived ? const Color(0xFF4CAF50) : const Color(0xFF2196F3),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    isReceived
                        ? LocaleKeys.transactionsReceivedWithToken.trArgs(["BTC"])
                        : LocaleKeys.transactionsSentWithToken.trArgs(["BTC"]),
                    style: context.appThemes.medium16.copyWith(
                      color: context.appThemes.ink100,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dateStr,
                    style: context.appThemes.regular14.copyWith(color: context.appThemes.ink40),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: .end,
              children: [
                Text(
                  amountUsd,
                  style: context.appThemes.bold16.copyWith(
                    color: context.appThemes.ink100,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  amountCrypto,
                  style: context.appThemes.regular12.copyWith(color: context.appThemes.ink40),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String retrieveTransactionMessage(TransactionResponseObject transaction) {
    if (transaction.transactionType == TransactionType.SOL_TRANSFER) {
      return LocaleKeys.transferredPrefix.trArgs([transaction.overview?.slot.toString() ?? ""]);
    }
    if (transaction.transactionType == TransactionType.SPL_TOKEN_TRANSFER) {
      return LocaleKeys.transferredPrefix.trArgs([transaction.overview?.slot.toString() ?? ""]);
    }
    if (transaction.transactionType ==
        TransactionType.SPL_TOKEN_TRANSFER_WITH_TOKEN_ACCOUNT_CREATION) {
      return LocaleKeys.transferredPrefix.trArgs([transaction.overview?.slot.toString() ?? ""]);
    }
    if (transaction.transactionType == TransactionType.SWAP) {
      return LocaleKeys.transferredPrefix.trArgs([transaction.overview?.slot.toString() ?? ""]);
    }
    if (transaction.transactionType == TransactionType.SWAP_WITH_TOKEN_ACCOUNT_CREATION) {
      return LocaleKeys.transferredPrefix.trArgs([transaction.overview?.slot.toString() ?? ""]);
    }
    if (transaction.transactionType == TransactionType.STAKE) {
      return LocaleKeys.transferredPrefix.trArgs([transaction.overview?.slot.toString() ?? ""]);
    }
    if (transaction.transactionType == TransactionType.CREATE_TOKEN_ACCOUNT) {
      return LocaleKeys.transferredPrefix.trArgs([transaction.overview?.slot.toString() ?? ""]);
    }
    return LocaleKeys.transferredPrefix.trArgs([transaction.overview?.slot.toString() ?? ""]);
  }

  String retrieveTransactionPrice(TransactionResponseObject transaction) {
    return "";
  }

  _buildLabel(
    BuildContext context,
    TransactionResponseObject transaction, {
    required bool isFirst,
  }) {
    return Padding(
      padding: const .only(left: 16, right: 16, bottom: 12),
      child: Text(
        retrieveGroupLabel(transaction),
        style: context.appThemes.regular14.copyWith(color: context.appThemes.ink40),
      ),
    );
  }

  String retrieveGroupLabel(TransactionResponseObject transaction) {
    final timestamp = transaction.overview?.timestamp;
    if (timestamp == null) return "";

    final now = Jiffy.now();
    if (timestamp.isSame(now, unit: Unit.day)) {
      return LocaleKeys.today.tr;
    }
    if (timestamp.isSame(now.subtract(days: 1), unit: Unit.day)) {
      return LocaleKeys.yesterday.tr;
    }

    return "${timestamp.EEEE} - ${timestamp.date}/${timestamp.month}/${timestamp.year}";
  }
}
