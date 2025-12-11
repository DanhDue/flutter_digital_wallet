// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/app/modules/wallet_token_info/controllers/wallet_token_info_controller.dart';
import 'package:d3_wallet/base/widgets/custom_unfilled_button.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class WalletTokenInfoView extends StatefulWidget {
  const WalletTokenInfoView({super.key, this.selectedWallet, this.balanceIsHidden});

  final WalletResponseObject? selectedWallet;

  final bool? balanceIsHidden;

  @override
  State<WalletTokenInfoView> createState() => _WalletTokenInfoViewState();
}

class _WalletTokenInfoViewState extends State<WalletTokenInfoView> with TickerProviderStateMixin {
  final controller = Get.put(WalletTokenInfoController(), permanent: false);

  late final TabController _tabController;
  var _selectedTabbar = 0;
  @override
  void initState() {
    super.initState();
    controller.updateSelectedWallet(widget.selectedWallet);
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TabBar.secondary(
          onTap: (index) {
            setState(() {
              _selectedTabbar = index;
            });
          },
          splashFactory: NoSplash.splashFactory,
          indicatorWeight: 2,
          indicatorColor: context.appThemes.blue100,
          dividerColor: context.appThemes.ink5,
          labelColor: context.appThemes.blue100,
          unselectedLabelColor: context.appThemes.ink20,
          controller: _tabController,
          tabs: <Widget>[Tab(text: LocaleKeys.token.tr), Tab(text: LocaleKeys.nft.tr)],
        ),
        Builder(
          builder: (_) {
            if (_selectedTabbar == 0) {
              return _buildTokenView(context, widget.selectedWallet, widget.balanceIsHidden);
            } else if (_selectedTabbar == 1) {
              return _buildNFTView(context, widget.balanceIsHidden);
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }

  _buildTokenView(
    BuildContext context,
    WalletResponseObject? selectedWallet,
    bool? balanceIsHidden,
  ) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              LocaleKeys.tokenList.tr,
              style: context.appThemes.bold14.copyWith(color: context.appThemes.ink100),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [],
          ),
        ],
      ),
    );
  }

  _buildNFTView(BuildContext context, bool? balanceIsHidden) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Visibility(
          visible: false,
          maintainAnimation: true,
          maintainState: true,
          maintainSize: true,
          child: _buildTokenView(context, widget.selectedWallet, balanceIsHidden),
        ),
        _buildNFTNoDataView(context),
      ],
    );
  }

  _buildNFTNoDataView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              LocaleKeys.txtNFTList.tr,
              style: context.appThemes.bold14.copyWith(color: context.appThemes.ink100),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: 12),
          _buildEmptyNFTLayouts(context),
        ],
      ),
    );
  }

  _buildEmptyNFTLayouts(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.images.icIllusEmptyNft.svg(width: 180, height: 180, fit: BoxFit.cover),
          SizedBox(height: 4),
          Text(
            LocaleKeys.nftNotFoundMessage.tr,
            style: context.appThemes.regular14.copyWith(color: context.appThemes.ink40),
          ),
          SizedBox(height: 4),
          CustomUnfilledButton(text: LocaleKeys.addNFT.tr, onPressed: () => Fimber.d("Add NFT")),
        ],
      ),
    );
  }
}
