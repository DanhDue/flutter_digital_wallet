// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:cached_network_image/cached_network_image.dart';
import 'package:d3_wallet/data/bean/response/network_object/network_object.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:d3_wallet/utils/constants.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:material_text_fields/theme/material_text_field_theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../controllers/network_selection_controller.dart';

class NetworkSelectionView extends StatefulWidget {
  const NetworkSelectionView({super.key, this.selectedNetwork});

  final NetworkObject? selectedNetwork;

  @override
  State<NetworkSelectionView> createState() => _NetworkSelectionViewState();
}

class _NetworkSelectionViewState extends State<NetworkSelectionView> {
  final controller = Get.put(NetworkSelectionController(), permanent: false);

  @override
  void initState() {
    super.initState();
    Fimber.d("initState()");
    controller.setInputs(widget.selectedNetwork);
  }

  @override
  void dispose() {
    controller.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // call this method here to hide soft keyboard
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return CupertinoScaffold(
            transitionBackgroundColor: Colors.transparent,
            body: Container(
              color: context.appThemes.white,
              child: Wrap(
                children: [
                  Column(
                    mainAxisAlignment: .start,
                    crossAxisAlignment: .center,
                    mainAxisSize: .min,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: .start,
                          crossAxisAlignment: .center,
                          mainAxisSize: .max,
                          children: [
                            InkWell(
                              onTap: () => Get.back(),
                              child: Container(
                                width: 36,
                                height: 36,
                                padding: const .all(6),
                                child: Assets.images.icCloseRound.svg(fit: .contain),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                LocaleKeys.selectNetwork.tr,
                                style: context.appThemes.medium16.copyWith(
                                  color: context.appThemes.ink100,
                                ),
                                textAlign: .center,
                              ),
                            ),
                            Visibility(
                              visible: false,
                              maintainSize: true,
                              maintainState: true,
                              maintainAnimation: true,
                              child: Assets.images.icCloseRound.svg(
                                width: 36,
                                height: 36,
                                fit: .contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1, color: context.appThemes.ink5),
                      Padding(
                        padding: const .symmetric(horizontal: 16),
                        child: Column(
                          mainAxisAlignment: .start,
                          crossAxisAlignment: .center,
                          mainAxisSize: .min,
                          children: [
                            SizedBox(height: 16),
                            Obx(
                              () => Focus(
                                onFocusChange: (hasFocus) {
                                  controller.filterTextIsFocus.value = hasFocus;
                                },
                                child: MaterialTextField(
                                  style: context.appThemes.regular14,
                                  keyboardType: .text,
                                  hint: LocaleKeys.search.tr,
                                  labelText: LocaleKeys.search.tr,
                                  textInputAction: .next,
                                  prefixIcon: Container(
                                    padding: const .all(10),
                                    child: Icon(
                                      Icons.search_outlined,
                                      size: 32,
                                      color: controller.filterTextIsFocus.value
                                          ? context.appThemes.trueBlue
                                          : context.appThemes.ink40,
                                    ),
                                  ),
                                  suffixIcon: controller.showFilterTextClearIcon.value
                                      ? InkWell(
                                          onTap: () => controller.clearFilterredText(),
                                          child: Container(
                                            padding: const .all(10),
                                            child: Assets.images.icClear.svg(
                                              width: 10,
                                              height: 10,
                                              fit: .cover,
                                              colorFilter: .mode(
                                                context.appThemes.ink60,
                                                .srcATop,
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                  theme: FilledOrOutlinedTextTheme(
                                    radius: 6,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                    errorStyle: context.appThemes.regular14.copyWith(
                                      color: context.appThemes.red,
                                    ),
                                    fillColor: Colors.transparent,
                                    prefixIconColor: controller.filterTextIsFocus.value
                                        ? context.appThemes.trueBlue
                                        : context.appThemes.ink40,
                                    enabledColor: context.appThemes.ink10,
                                    focusedColor: context.appThemes.trueBlue,
                                    floatingLabelStyle: TextStyle(
                                      color: context.appThemes.trueBlue,
                                    ),
                                    labelStyle: context.appThemes.regular10.copyWith(
                                      color: context.appThemes.ink40,
                                    ),
                                    iconColor: controller.filterTextIsFocus.value
                                        ? context.appThemes.trueBlue
                                        : context.appThemes.ink40,
                                  ),
                                  controller: controller.filterTextEditingController,
                                  onChanged: (value) => controller.filterNetworksByName(value),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 232,
                        child: Obx(
                          () => !controller.filteredNetworks.isNotEmpty
                              ? _buildNotFoundItem(context)
                              : ListView(
                                  children: [
                                    for (final network in controller.filteredNetworks)
                                      _buildNetworkItem(context, network, controller),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _buildNotFoundItem(BuildContext context) {
    return Center(
      child: Container(
        padding: const .all(16),
        width: .infinity,
        alignment: .center,
        child: Text(
          LocaleKeys.searchingNotFound.tr,
          style: context.appThemes.regular14.copyWith(color: context.appThemes.ink100),
        ),
      ),
    );
  }

  _buildNetworkItem(
    BuildContext context,
    NetworkObject network,
    NetworkSelectionController controller,
  ) {
    return InkWell(
      onTap: () {
        controller.updateSelectedNetwork(network);
        Future.delayed(Duration(milliseconds: Constants.keyboardDismissDuration), () {
          Get.back(result: network);
        });
      },
      child: Obx(
        () => Container(
          padding: const .symmetric(horizontal: 16, vertical: 8),
          color: controller.selectedNetwork.value.name == network.name
              ? context.appThemes.blue0
              : context.appThemes.white,
          child: Row(
            mainAxisAlignment: .start,
            crossAxisAlignment: .center,
            mainAxisSize: .max,
            children: [
              if (network.id == NetworkIds.ALL)
                SizedBox(
                  width: 48,
                  height: 48,
                  child: Icon(
                    Icons.connected_tv_outlined,
                    size: 36,
                    color: context.appThemes.trueBlue,
                  ),
                )
              else
                Container(
                  width: 48,
                  height: 48,
                  padding: const .all(6),
                  child: ClipRRect(
                    borderRadius: .circular(20),
                    child: CachedNetworkImage(
                      imageUrl: network.logo ?? "",
                      width: 36,
                      height: 36,
                      fit: .cover,
                    ),
                  ),
                ),
              SizedBox(width: 16),
              Text(
                network.name ?? "",
                style: context.appThemes.medium16.copyWith(color: context.appThemes.ink100),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
