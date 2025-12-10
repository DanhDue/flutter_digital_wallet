// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/app/modules/onboard/s_r_p_description/bindings/s_r_p_description_binding.dart';
import 'package:d3_wallet/base/base_binding_creator_widget.dart';
import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/s_r_p_description_controller.dart';

class SRPDescriptionView
    extends BaseBindingCreatorView<SRPDescriptionBinding, SRPDescriptionController> {
  SRPDescriptionView({super.key, required super.bindingCreator});

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
                        "“Cụm từ khôi phục bí mật” là gì?",
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
                        text: "Cụm từ khôi phục bí mật",
                        style: context.appThemes.bold14.copyWith(color: context.appThemes.ink100),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                " là một nhóm gồm mười hai từ chứa tất cả thông tin về ví của bạn, bao gồm cả tiền trong đó. Nó như một mật mã bí mật được dùng để truy cập toàn bộ ví của bạn.\n\nBạn phải giữ ",
                            style: context.appThemes.regular14.copyWith(
                              color: context.appThemes.ink80,
                            ),
                          ),
                          TextSpan(
                            text: "Cụm từ khôi phục bí mật",
                            style: context.appThemes.bold14.copyWith(
                              color: context.appThemes.ink100,
                            ),
                          ),
                          TextSpan(
                            text:
                                " một cách bảo mật và an toàn. Nếu ai đó có được Cụm từ khôi phục bí mật của bạn, thì họ sẽ có toàn quyền kiểm soát các ví của bạn. Hãy lưu cụm từ này ở một nơi mà bạn có thể truy cập.",
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
                                  "Lưu ý",
                                  style: context.appThemes.medium14.copyWith(
                                    color: context.appThemes.ink80,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 2),
                                Text.rich(
                                  textAlign: TextAlign.left,
                                  TextSpan(
                                    text: "Nếu bạn làm mất, thì ngay cả SCoin cũng ",
                                    style: context.appThemes.regular12.copyWith(
                                      color: context.appThemes.ink60,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "không thể giúp bạn khôi phục",
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
