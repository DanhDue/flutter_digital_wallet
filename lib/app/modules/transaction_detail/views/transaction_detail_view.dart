// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/app/modules/transaction_detail/controllers/transaction_detail_controller.dart';
import 'package:d3_wallet/data/bean/response/transaction_overview_object/transaction_overview_object.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionDetailView extends GetView<TransactionDetailController> {
  const TransactionDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final transaction = controller.transaction;
    final overview = transaction.overview;

    return Scaffold(
      backgroundColor: context.appThemes.zenoBg,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 32),

                    // Status Icon & Badge
                    _buildStatusSection(context),

                    const SizedBox(height: 24),

                    // Amount Display
                    _buildAmountSection(context, transaction),

                    const SizedBox(height: 32),

                    // Transaction Info Card
                    _buildInfoCard(context, overview),

                    const SizedBox(height: 24),

                    // Token Transfers (if any)
                    if (transaction.tokenBalances?.isNotEmpty == true)
                      _buildTokenTransfers(context, transaction),

                    const SizedBox(height: 24),

                    // Metadata
                    _buildMetadata(context, overview),

                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Bottom Action Buttons
      bottomNavigationBar: _buildBottomActions(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const .all(16),
      decoration: BoxDecoration(
        color: context.appThemes.zenoBg.withValues(alpha: 0.9),
        border: Border(
          bottom: BorderSide(color: context.appThemes.zenoBorder.withValues(alpha: 0.3), width: 1),
        ),
      ),
      child: Row(
        children: [
          // Back Button
          InkWell(
            onTap: () => Get.back(),
            borderRadius: .circular(24),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: context.appThemes.zenoText.withValues(alpha: 0.1),
                borderRadius: .circular(24),
              ),
              child: Icon(Icons.arrow_back, color: context.appThemes.zenoText, size: 20),
            ),
          ),
          Expanded(
            child: Text(
              LocaleKeys.transactionDetails.tr,
              textAlign: .center,
              style: TextStyle(color: context.appThemes.zenoText, fontSize: 18, fontWeight: .bold),
            ),
          ),
          // Share Button
          InkWell(
            onTap: controller.shareReceipt,
            borderRadius: .circular(24),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: context.appThemes.zenoText.withValues(alpha: 0.1),
                borderRadius: .circular(24),
              ),
              child: Icon(Icons.share, color: context.appThemes.zenoText, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSection(BuildContext context) {
    return Column(
      children: [
        // Gradient Icon
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF037DD6), Color(0xFF1976D2)],
              begin: .topLeft,
              end: .bottomRight,
            ),
            borderRadius: .circular(40),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF037DD6).withValues(alpha: 0.5),
                blurRadius: 40,
                spreadRadius: -10,
              ),
            ],
            border: Border.all(color: context.appThemes.zenoBg, width: 4),
          ),
          child: const Icon(Icons.arrow_upward, color: Colors.white, size: 36),
        ),

        const SizedBox(height: 8),

        // Status Badge
        Container(
          padding: const .symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: context.appThemes.zenoSurface,
            borderRadius: .circular(20),
            border: Border.all(color: context.appThemes.zenoBorder),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: .min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: context.appThemes.zenoSuccess,
                  borderRadius: .circular(4),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                LocaleKeys.confirmed.tr.toUpperCase(),
                style: TextStyle(
                  color: context.appThemes.zenoSuccess,
                  fontSize: 12,
                  fontWeight: .w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAmountSection(BuildContext context, transaction) {
    return Column(
      children: [
        Text(
          '- 2.5 SOL',
          style: context.appThemes.bold24.copyWith(
            color: context.appThemes.zenoText,
            fontSize: 36,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '≈ \$365.25 USD',
          style: context.appThemes.medium16.copyWith(
            color: context.appThemes.zenoTextMuted,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context, overview) {
    final timestamp = overview?.timestamp;
    final dateStr = timestamp != null
        ? "${overview?.timestamp?.hour}:${overview?.timestamp?.minute}"
        : 'N/A';

    return Container(
      margin: const .symmetric(horizontal: 20),
      padding: const .all(20),
      decoration: BoxDecoration(
        color: context.appThemes.zenoSurface,
        borderRadius: .circular(24),
        border: Border.all(color: context.appThemes.zenoBorder.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Date
          _buildInfoRow(
            context,
            icon: Icons.calendar_today,
            label: LocaleKeys.date.tr,
            value: dateStr,
          ),

          _buildDivider(context),

          // From
          _buildAddressRow(
            context,
            icon: Icons.logout,
            label: LocaleKeys.from.tr,
            address: overview?.payerAddress ?? '',
            gradientColors: const [Color(0xFF9C27B0), Color(0xFF2196F3)],
          ),

          // To
          _buildAddressRow(
            context,
            icon: Icons.login,
            label: LocaleKeys.to.tr,
            address: overview?.payerAddress ?? '',
            gradientColors: const [Color(0xFFFF9800), Color(0xFFE91E63)],
          ),

          _buildDivider(context),

          // Network Fee
          _buildInfoRow(
            context,
            icon: Icons.local_gas_station,
            label: LocaleKeys.networkFee.tr,
            value: '0.000005 SOL',
            subtitle: '(< \$0.01)',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    String? subtitle,
  }) {
    return Padding(
      padding: const .symmetric(vertical: 12),
      child: Row(
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: context.appThemes.zenoTextMuted),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: context.appThemes.zenoTextMuted,
                  fontSize: 14,
                  fontWeight: .w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: .end,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: context.appThemes.zenoText,
                  fontSize: 14,
                  fontWeight: .w600,
                ),
              ),
              if (subtitle != null)
                Text(
                  subtitle,
                  style: TextStyle(color: context.appThemes.zenoTextMuted, fontSize: 12),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddressRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String address,
    required List<Color> gradientColors,
  }) {
    final shortAddress = address.length > 8
        ? '${address.substring(0, 4)}...${address.substring(address.length - 4)}'
        : address;

    return Padding(
      padding: const .symmetric(vertical: 12),
      child: Row(
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: context.appThemes.zenoTextMuted),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: context.appThemes.zenoTextMuted,
                  fontSize: 14,
                  fontWeight: .w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const .symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: context.appThemes.zenoBg.withValues(alpha: 0.5),
              borderRadius: .circular(8),
              border: Border.all(color: context.appThemes.zenoBorder.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: .min,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors,
                      begin: .topLeft,
                      end: .bottomRight,
                    ),
                    borderRadius: .circular(10),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  shortAddress,
                  style: TextStyle(
                    color: context.appThemes.zenoText,
                    fontSize: 14,
                    fontWeight: .w500,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(width: 4),
                InkWell(
                  onTap: () => controller.copyToClipboard(address),
                  child: Icon(Icons.copy, size: 16, color: context.appThemes.zenoTextMuted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Container(height: 1, color: context.appThemes.zenoBorder.withValues(alpha: 0.5));
  }

  Widget _buildTokenTransfers(BuildContext context, transaction) {
    return Padding(
      padding: const .symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            LocaleKeys.tokenTransfers.tr.toUpperCase(),
            style: TextStyle(
              color: context.appThemes.zenoTextMuted,
              fontSize: 12,
              fontWeight: .bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const .all(16),
            decoration: BoxDecoration(
              color: context.appThemes.zenoSurface,
              borderRadius: .circular(24),
              border: Border.all(color: context.appThemes.zenoBorder.withValues(alpha: 0.5)),
            ),
            child: Row(
              children: [
                // Token Icon
                Stack(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2775CA),
                        borderRadius: .circular(16),
                      ),
                      child: const Center(
                        child: Text(
                          '\$',
                          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: .bold),
                        ),
                      ),
                    ),
                    Positioned(
                      right: -4,
                      bottom: -4,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: context.appThemes.zenoSurface,
                          borderRadius: .circular(10),
                          border: Border.all(color: context.appThemes.zenoSurface, width: 2),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: .circular(8),
                          ),
                          child: const Icon(Icons.circle, size: 12, color: Color(0xFF00D4AA)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      'USDC',
                      style: TextStyle(
                        color: context.appThemes.zenoText,
                        fontSize: 18,
                        fontWeight: .bold,
                      ),
                    ),
                    Text(
                      LocaleKeys.splToken.tr,
                      style: TextStyle(
                        color: context.appThemes.zenoTextMuted,
                        fontSize: 12,
                        fontWeight: .w500,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: .end,
                  children: [
                    Text(
                      '- 500.00',
                      style: TextStyle(
                        color: context.appThemes.zenoText,
                        fontSize: 18,
                        fontWeight: .bold,
                      ),
                    ),
                    Text(
                      '≈ \$500.00',
                      style: TextStyle(
                        color: context.appThemes.zenoTextMuted,
                        fontSize: 12,
                        fontWeight: .w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetadata(BuildContext context, TransactionOverviewObject? overview) {
    final slot = overview?.slot?.toString() ?? 'N/A';
    final signature = overview?.signature?.firstOrNull ?? '';
    final shortSignature = signature.length > 8
        ? '${signature.substring(0, 4)}...${signature.substring(signature.length - 4)}'
        : signature;

    return Container(
      margin: const .symmetric(horizontal: 20),
      padding: const .all(16),
      decoration: BoxDecoration(
        color: context.appThemes.zenoSurface.withValues(alpha: 0.5),
        borderRadius: .circular(16),
        border: Border.all(color: context.appThemes.zenoBorder.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                LocaleKeys.slot.tr,
                style: TextStyle(
                  color: context.appThemes.zenoTextMuted,
                  fontSize: 12,
                  fontWeight: .w500,
                ),
              ),
              Text(
                slot,
                style: TextStyle(
                  color: context.appThemes.zenoTextMuted,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                LocaleKeys.signature.tr,
                style: TextStyle(
                  color: context.appThemes.zenoTextMuted,
                  fontSize: 12,
                  fontWeight: .w500,
                ),
              ),
              InkWell(
                onTap: controller.openExplorer,
                child: Row(
                  children: [
                    Text(
                      shortSignature,
                      style: const TextStyle(
                        color: Color(0xFF4DA3FF),
                        fontSize: 12,
                        fontWeight: .w500,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.open_in_new, size: 14, color: Color(0xFF4DA3FF)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Container(
      padding: const .all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: .topCenter,
          end: .bottomCenter,
          colors: [
            context.appThemes.zenoBg.withValues(alpha: 0),
            context.appThemes.zenoBg.withValues(alpha: 0.95),
            context.appThemes.zenoBg,
          ],
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Explorer Button
            Expanded(
              child: InkWell(
                onTap: controller.openExplorer,
                borderRadius: .circular(16),
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: context.appThemes.zenoSurface,
                    borderRadius: .circular(16),
                    border: Border.all(color: context.appThemes.zenoBorder),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: .center,
                    children: [
                      Icon(Icons.explore, color: context.appThemes.zenoText, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        LocaleKeys.explorer.tr,
                        style: TextStyle(
                          color: context.appThemes.zenoText,
                          fontSize: 14,
                          fontWeight: .w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Share Receipt Button
            Expanded(
              child: InkWell(
                onTap: controller.shareReceipt,
                borderRadius: .circular(16),
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFF037DD6), Color(0xFF4DA3FF)]),
                    borderRadius: .circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF037DD6).withValues(alpha: 0.5),
                        blurRadius: 20,
                        spreadRadius: -5,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: .center,
                    children: [
                      const Icon(Icons.ios_share, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        LocaleKeys.shareReceipt.tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: .bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
