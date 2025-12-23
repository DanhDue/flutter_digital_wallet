// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/app/modules/comming_soon_modal/bindings/comming_soon_modal_binding.dart';
import 'package:d3_wallet/base/base_binding_creator_widget.dart';
import 'package:d3_wallet/base/dialog_mixin.dart';
import 'package:d3_wallet/base/widgets/custom_filled_button.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../controllers/comming_soon_modal_controller.dart';

class CommingSoonModalView
    extends BaseBindingCreatorView<CommingSoonModalBinding, CommingSoonModalController>
    with DialogMixin {
  CommingSoonModalView({super.key, super.bindingCreator});

  @override
  Widget? onCreateViews(BuildContext context) {
    return CupertinoScaffold(
      transitionBackgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.icCommingSoonBackground.provider(),
            fit: .cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .center,
          mainAxisSize: .min,
          children: [
            InkWell(
              onTap: () => Get.back(),
              child: Padding(
                padding: const .symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  width: .infinity,
                  alignment: .centerLeft,
                  child: Container(
                    width: 36,
                    height: 36,
                    padding: const .all(6),
                    child: Assets.images.icCloseRound.svg(fit: BoxFit.contain),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const .symmetric(horizontal: 16),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: .start,
                  crossAxisAlignment: .center,
                  mainAxisSize: .min,
                  children: [
                    const SizedBox(height: 36),
                    Assets.images.icRocketLaunch.svg(width: 153, height: 153, fit: .cover),
                    const SizedBox(height: 20),
                    Text(
                      LocaleKeys.commingSoon.tr,
                      style: context.appThemes.bold24.copyWith(color: context.appThemes.ink100),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      LocaleKeys.commingSoonDescription.tr,
                      style: context.appThemes.regular16.copyWith(color: context.appThemes.ink60),
                      textAlign: .center,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: .spaceAround,
                      crossAxisAlignment: .center,
                      children: [
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              color: context.appThemes.white,
                              borderRadius: .circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: context.appThemes.black.withValues(alpha: 0.05),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            padding: const .symmetric(horizontal: 24, vertical: 4),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: LocaleKeys.enterYourEmail.tr,
                                hintStyle: context.appThemes.regular16.copyWith(
                                  color: context.appThemes.textGrey,
                                ),
                                border: .none,
                                enabledBorder: .none,
                                focusedBorder: .none,
                              ),
                              style: context.appThemes.regular16.copyWith(
                                color: context.appThemes.textColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        CustomFilledButton(
                          borderRadius: 100,
                          onPressed: () => showCommingSoon(context),
                          text: LocaleKeys.subscribe.tr,
                          fullWidth: false,
                        ),
                      ],
                    ),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
