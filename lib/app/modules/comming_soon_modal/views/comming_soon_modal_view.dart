// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/app/modules/comming_soon_modal/bindings/comming_soon_modal_binding.dart';
import 'package:d3_wallet/base/base_binding_creator_widget.dart';
import 'package:d3_wallet/base/widgets/custom_filled_button.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/comming_soon_modal_controller.dart';

class CommingSoonModalView
    extends BaseBindingCreatorView<CommingSoonModalBinding, CommingSoonModalController> {
  CommingSoonModalView({super.key, required super.bindingCreator});

  @override
  Widget? onCreateViews(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Assets.images.icCommingSoonBackground.provider(),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => Get.back(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 36,
                  height: 36,
                  padding: EdgeInsets.all(6),
                  child: Assets.images.icCloseRound.svg(fit: BoxFit.contain),
                ),
              ),
            ),
          ),
          SizedBox(height: 36),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Assets.images.icRocketLaunch.svg(width: 153, height: 153, fit: BoxFit.cover),
                  SizedBox(height: 20),
                  Text(
                    LocaleKeys.commingSoon.tr,
                    style: context.appThemes.bold24.copyWith(color: context.appThemes.ink100),
                  ),
                  SizedBox(height: 16),
                  Text(
                    LocaleKeys.commingSoonDescription.tr,
                    style: context.appThemes.regular16.copyWith(color: context.appThemes.ink60),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                            color: context.appThemes.white,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                color: context.appThemes.black.withValues(alpha: 0.05),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: LocaleKeys.enterYourEmail.tr,
                              hintStyle: context.appThemes.regular16.copyWith(
                                color: context.appThemes.textGrey,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            style: context.appThemes.regular16.copyWith(
                              color: context.appThemes.textColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      CustomFilledButton(
                        borderRadius: 100,
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            enableDrag: true,
                            useSafeArea: false,
                            isScrollControlled: true,
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height,
                              minHeight: 0,
                            ),
                            builder:
                                (context) => MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: CommingSoonModalView(
                                    bindingCreator: () => CommingSoonModalBinding(),
                                  ),
                                ),
                          );
                        },
                        text: LocaleKeys.subscribe.tr,
                        fullWidth: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 70),
        ],
      ),
    );
  }
}
