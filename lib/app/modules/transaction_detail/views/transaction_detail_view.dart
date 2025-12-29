// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/app/modules/transaction_detail/controllers/transaction_detail_controller.dart';
import 'package:d3_wallet/data/bean/response/transaction_overview_object/transaction_overview_object.dart';
import 'package:d3_wallet/generated/colors.gen.dart';
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
      backgroundColor: AppColors.zenoBg,
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
        color: AppColors.zenoBg.withOpacity(0.9),
        border: Border(bottom: BorderSide(color: AppColors.zenoBorder.withOpacity(0.3), width: 1)),
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
                color: Colors.white.withOpacity(0.1),
                borderRadius: .circular(24),
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            ),
          ),

          const Expanded(
            child: Text(
              'Transaction Details',
              textAlign: .center,
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
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
                color: Colors.white.withOpacity(0.1),
                borderRadius: .circular(24),
              ),
              child: const Icon(Icons.share, color: Colors.white, size: 20),
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
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: .circular(40),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF037DD6).withOpacity(0.5),
                blurRadius: 40,
                spreadRadius: -10,
              ),
            ],
            border: Border.all(color: AppColors.zenoBg, width: 4),
          ),
          child: const Icon(Icons.arrow_upward, color: Colors.white, size: 36),
        ),

        const SizedBox(height: 8),

        // Status Badge
        Container(
          padding: const .symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.zenoSurface,
            borderRadius: .circular(20),
            border: Border.all(color: AppColors.zenoBorder),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
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
                  color: AppColors.zenoSuccess,
                  borderRadius: .circular(4),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'CONFIRMED',
                style: TextStyle(
                  color: AppColors.zenoSuccess,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
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
          style: context.appThemes.bold24.copyWith(color: Colors.white, fontSize: 36),
        ),
        const SizedBox(height: 8),
        Text(
          '≈ \$365.25 USD',
          style: context.appThemes.medium16.copyWith(
            color: context.appThemes.textGrey,
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
        color: AppColors.zenoSurface,
        borderRadius: .circular(24),
        border: Border.all(color: AppColors.zenoBorder.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Date
          _buildInfoRow(context, icon: Icons.calendar_today, label: 'Date', value: dateStr),

          _buildDivider(),

          // From
          _buildAddressRow(
            context,
            icon: Icons.logout,
            label: 'From',
            address: overview?.payerAddress ?? '',
            gradientColors: const [Color(0xFF9C27B0), Color(0xFF2196F3)],
          ),

          // To
          _buildAddressRow(
            context,
            icon: Icons.login,
            label: 'To',
            address: overview?.payerAddress ?? '',
            gradientColors: const [Color(0xFFFF9800), Color(0xFFE91E63)],
          ),

          _buildDivider(),

          // Network Fee
          _buildInfoRow(
            context,
            icon: Icons.local_gas_station,
            label: 'Network Fee',
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
              Icon(icon, size: 20, color: context.appThemes.textGrey),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: context.appThemes.textGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
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
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (subtitle != null)
                Text(subtitle, style: TextStyle(color: context.appThemes.textGrey, fontSize: 12)),
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
              Icon(icon, size: 20, color: context.appThemes.textGrey),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: context.appThemes.textGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const .symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.zenoBg.withOpacity(0.5),
              borderRadius: .circular(8),
              border: Border.all(color: AppColors.zenoBorder.withOpacity(0.3)),
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
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: .circular(10),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  shortAddress,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(width: 4),
                InkWell(
                  onTap: () => controller.copyToClipboard(address),
                  child: Icon(Icons.copy, size: 16, color: context.appThemes.textGrey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 1, color: AppColors.zenoBorder.withOpacity(0.5));
  }

  Widget _buildTokenTransfers(BuildContext context, transaction) {
    return Padding(
      padding: const .symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            'TOKEN TRANSFERS',
            style: TextStyle(
              color: context.appThemes.textGrey,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const .all(16),
            decoration: BoxDecoration(
              color: AppColors.zenoSurface,
              borderRadius: .circular(24),
              border: Border.all(color: AppColors.zenoBorder.withOpacity(0.5)),
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
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
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
                          color: AppColors.zenoSurface,
                          borderRadius: .circular(10),
                          border: Border.all(color: AppColors.zenoSurface, width: 2),
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
                    const Text(
                      'USDC',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'SPL Token',
                      style: TextStyle(
                        color: context.appThemes.textGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: .end,
                  children: [
                    const Text(
                      '- 500.00',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '≈ \$500.00',
                      style: TextStyle(
                        color: context.appThemes.textGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
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
        color: AppColors.zenoSurface.withOpacity(0.5),
        borderRadius: .circular(16),
        border: Border.all(color: AppColors.zenoBorder.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                'Slot',
                style: TextStyle(
                  color: context.appThemes.textGrey,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                slot,
                style: TextStyle(
                  color: context.appThemes.textGrey,
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
                'Signature',
                style: TextStyle(
                  color: context.appThemes.textGrey,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
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
                        fontWeight: FontWeight.w500,
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
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.zenoBg.withOpacity(0),
            AppColors.zenoBg.withOpacity(0.95),
            AppColors.zenoBg,
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
                    color: AppColors.zenoSurface,
                    borderRadius: .circular(16),
                    border: Border.all(color: AppColors.zenoBorder),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: .center,
                    children: [
                      const Icon(Icons.explore, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        'Explorer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
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
                        color: const Color(0xFF037DD6).withOpacity(0.5),
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
                      const Text(
                        'Share Receipt',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
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
