// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/app/modules/onboard/s_r_p_description/bindings/s_r_p_description_binding.dart';
import 'package:d3_wallet/base/base_binding_creator_widget.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/s_r_p_description_controller.dart';

class SRPDescriptionView
    extends BaseBindingCreatorView<SRPDescriptionBinding, SRPDescriptionController> {
  SRPDescriptionView({super.key, super.bindingCreator});

  @override
  Widget? onCreateViews(BuildContext context) {
    return Container(
      color: context.appThemes.white,
      child: Wrap(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        width: 36,
                        height: 36,
                        padding: EdgeInsets.all(6),
                        child: Assets.images.icCloseRound.svg(fit: BoxFit.contain),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.whatIsSRP.tr,
                        style: context.appThemes.medium16.copyWith(
                          color: context.appThemes.ink100,
                        ),
                        textAlign: TextAlign.center,
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
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, color: context.appThemes.ink5),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 8),
                    Assets.images.icIllusSeedPhrase.image(
                      width: 178,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 16),
                    Text.rich(
                      textAlign: TextAlign.left,
                      TextSpan(
                        text: LocaleKeys.secretRecoveryPhrase.tr,
                        style: context.appThemes.bold14.copyWith(color: context.appThemes.ink100),
                        children: <TextSpan>[
                          TextSpan(
                            text: LocaleKeys.srpDefinitionPart1.tr,
                            style: context.appThemes.regular14.copyWith(
                              color: context.appThemes.ink80,
                            ),
                          ),
                          TextSpan(
                            text: LocaleKeys.secretRecoveryPhrase.tr,
                            style: context.appThemes.bold14.copyWith(
                              color: context.appThemes.ink100,
                            ),
                          ),
                          TextSpan(
                            text: LocaleKeys.srpDefinitionPart2.tr,
                            style: context.appThemes.regular14.copyWith(
                              color: context.appThemes.ink80,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: context.appThemes.red0,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: context.appThemes.red100),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Assets.images.icWarning.svg(
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              context.appThemes.ink40,
                              BlendMode.srcATop,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  LocaleKeys.note.tr,
                                  style: context.appThemes.medium14.copyWith(
                                    color: context.appThemes.ink80,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 2),
                                Text.rich(
                                  textAlign: TextAlign.left,
                                  TextSpan(
                                    text: LocaleKeys.srpWarningPart1.tr,
                                    style: context.appThemes.regular12.copyWith(
                                      color: context.appThemes.ink60,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: LocaleKeys.srpWarningPart2.tr,
                                        style: context.appThemes.bold12.copyWith(
                                          color: context.appThemes.ink100,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 34),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
