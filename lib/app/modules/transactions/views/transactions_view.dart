// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/app/modules/transactions/bindings/transactions_binding.dart';
import 'package:d3_wallet/base/infinite_list/base_infinite_lis_view_with_binding_creator.dart';
import 'package:d3_wallet/data/bean/response/transaction_response_object/transaction_response_object.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:d3_wallet/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:jiffy/jiffy.dart';

import '../controllers/transactions_controller.dart';

class TransactionsView
    extends BaseInfiniteListViewWithCreator<TransactionsBinding, TransactionsController> {
  TransactionsView({super.key});

  @override
  Widget buildItemViews(BuildContext context, {item, int? index}) {
    if (item is TransactionResponseObject) {
      return _buildItem(context, item, index: index);
    }
    return const SizedBox.shrink();
  }

  _buildItem(BuildContext context, TransactionResponseObject transaction, {int? index}) {
    if (transaction.isLabel == true) return _buildLabel(context, transaction, isFirst: index == 0);
    return GestureDetector(
      onTap: () {
        Get.toNamed('/transaction-detail', arguments: transaction);
      },
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          Text(
            "${transaction.overview?.timestamp?.hour}:${transaction.overview?.timestamp?.minute}",
            style: context.appThemes.regular10.copyWith(color: context.appThemes.ink100),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: .start,
            crossAxisAlignment: .center,
            mainAxisSize: .max,
            children: [
              _retrieveTransactionIcon(transaction),
              const SizedBox(width: 12),
              Column(
                mainAxisAlignment: .start,
                crossAxisAlignment: .start,
                mainAxisSize: .max,
                children: [
                  Text(
                    retrieveTransactionMessage(transaction),
                    style: context.appThemes.regular14.copyWith(color: context.appThemes.ink100),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    padding: const .symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: context.appThemes.green10,
                      borderRadius: .circular(100),
                    ),
                    child: Text(
                      LocaleKeys.success.tr,
                      style: context.appThemes.regular10.copyWith(
                        color: context.appThemes.green100,
                      ),
                    ),
                  ),
                ],
              ),
              const Expanded(child: SizedBox.shrink()),
              Column(
                mainAxisAlignment: .end,
                crossAxisAlignment: .end,
                mainAxisSize: .max,
                children: [
                  Text(
                    "${transaction.overview?.signature?.firstOrNull?.substring(0, 7)}...${transaction.overview?.signature?.firstOrNull?.substring(transaction.overview?.signature?.firstOrNull?.length ?? 0 - 4)}",
                    style: context.appThemes.medium14.copyWith(color: context.appThemes.ink100),
                  ),
                  Text(
                    "${transaction.overview?.payerAddress?.substring(0, 7)}...${transaction.overview?.payerAddress?.substring(transaction.overview?.payerAddress?.length ?? 0 - 4)}",
                    style: context.appThemes.regular10.copyWith(color: context.appThemes.ink60),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ).marginSymmetric(horizontal: 20),
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

  _retrieveTransactionIcon(TransactionResponseObject transaction) {
    if (transaction.transactionType == TransactionType.SOL_TRANSFER) {
      return Assets.images.icSendTransaction.image(width: 36, height: 36, fit: .cover);
    }
    if (transaction.transactionType == TransactionType.SPL_TOKEN_TRANSFER) {
      return Assets.images.icSendTransaction.image(width: 36, height: 36, fit: .cover);
    }
    if (transaction.transactionType ==
        TransactionType.SPL_TOKEN_TRANSFER_WITH_TOKEN_ACCOUNT_CREATION) {
      return Assets.images.icStakingTransaction.image(width: 36, height: 36, fit: .cover);
    }
    if (transaction.transactionType == TransactionType.SWAP) {
      return Assets.images.icStakingTransaction.image(width: 36, height: 36, fit: .cover);
    }
    if (transaction.transactionType == TransactionType.SWAP_WITH_TOKEN_ACCOUNT_CREATION) {
      return Assets.images.icStakingTransaction.image(width: 36, height: 36, fit: .cover);
    }
    if (transaction.transactionType == TransactionType.STAKE) {
      return Assets.images.icStakingTransaction.image(width: 36, height: 36, fit: .cover);
    }
    if (transaction.transactionType == TransactionType.CREATE_TOKEN_ACCOUNT) {
      return Assets.images.icBuyTransaction.image(width: 36, height: 36, fit: .cover);
    }
    return Assets.images.icReceiveTransaction.image(width: 36, height: 36, fit: .cover);
  }
}
