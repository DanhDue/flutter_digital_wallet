// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/app/modules/my_tokens/bindings/my_tokens_binding.dart';
import 'package:d3_wallet/app/modules/my_tokens/views/my_tokens_view.dart';
import 'package:d3_wallet/app/modules/wallet_token_info/controllers/wallet_token_info_controller.dart';
import 'package:d3_wallet/base/widgets/custom_unfilled_button.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:d3_wallet/widgets/rectangular_indicator.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_utils/src/extensions/export.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            border: Border.all(color: context.appThemes.trueBlue, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            labelPadding: EdgeInsets.symmetric(vertical: 0),
            indicatorPadding: EdgeInsetsGeometry.symmetric(vertical: 4),
            onTap: (index) {
              setState(() {
                _selectedTabbar = index;
              });
            },
            splashFactory: NoSplash.splashFactory,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            dividerColor: Colors.transparent,
            labelColor: Colors.white,
            unselectedLabelColor: context.appThemes.ink40,
            labelStyle: context.appThemes.bold14,
            unselectedLabelStyle: context.appThemes.bold14,
            indicator: RectangularIndicator(
              color: context.appThemes.trueBlue,
              bottomLeftRadius: 6,
              bottomRightRadius: 6,
              topLeftRadius: 6,
              topRightRadius: 6,
              horizontalPadding: 0,
              verticalPadding: 0,
              paintingStyle: PaintingStyle.fill,
            ),
            controller: _tabController,
            tabs: <Widget>[Tab(text: LocaleKeys.token.tr), Tab(text: LocaleKeys.nft.tr)],
          ),
        ),
        Expanded(
          child: Builder(
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
        ),
      ],
    );
  }

  _buildTokenView(
    BuildContext context,
    WalletResponseObject? selectedWallet,
    bool? balanceIsHidden,
  ) {
    return MyTokensView(
      selectedWallet: selectedWallet,
      balanceIsHidden: balanceIsHidden,
      bindingCreator: () => MyTokensBinding(),
    ).paddingOnly(top: 6);
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
        children: [const SizedBox(height: 56), _buildEmptyNFTLayouts(context)],
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
          Assets.images.icNoFound.svg(width: 86, fit: BoxFit.cover),
          SizedBox(height: 4),
          Text(
            LocaleKeys.nftNotFoundMessage.tr,
            style: context.appThemes.regular14.copyWith(color: context.appThemes.ink60),
          ),
          SizedBox(height: 4),
          CustomUnfilledButton(text: LocaleKeys.addNFT.tr, onPressed: () => Fimber.d("Add NFT")),
        ],
      ),
    );
  }
}
