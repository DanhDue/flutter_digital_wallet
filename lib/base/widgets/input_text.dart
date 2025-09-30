// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';

class InputText extends StatelessWidget {
  const InputText({
    super.key,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.labelText,
    this.hintText,
    this.suffixIcon,
    this.showPrefixIconsDivider,
    this.secondSuffixIcon,
    this.onSecondSuffixIconTap,
    this.status = InputTextStatus.normal,
    this.keyboardType,
    this.obscureText,
    this.minLines,
    this.maxLines = 1,
    this.textInputAction,
    this.onFieldSubmitted,
    this.maxLength,
    this.counterText,
    this.counterStyle,
    this.counter,
    this.enableInteractiveSelection = true,
  });

  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final bool? showPrefixIconsDivider;
  final Widget? secondSuffixIcon;
  final GestureTapCallback? onSecondSuffixIconTap;
  final InputTextStatus? status;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final int? maxLines;
  final int? minLines;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final int? maxLength;
  final String? counterText;
  final TextStyle? counterStyle;
  final Widget? counter;
  final bool? enableInteractiveSelection;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: status == InputTextStatus.focus ? 4 : 4,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color:
              status == InputTextStatus.normal
                  ? context.appThemes.ink10
                  : (status == InputTextStatus.focus
                      ? context.appThemes.blue40
                      : context.appThemes.red),
        ),
        color: context.appThemes.transparent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: TextFormField(
              focusNode: focusNode,
              textInputAction: textInputAction ?? TextInputAction.done,
              onChanged: onChanged,
              controller: controller,
              keyboardType: keyboardType ?? TextInputType.text,
              obscureText: obscureText ?? false,
              style: context.appThemes.regular14.copyWith(color: context.appThemes.ink100),
              minLines: minLines,
              maxLines: maxLines,
              maxLength: maxLength,
              textAlign: TextAlign.start,
              contextMenuBuilder:
                  enableInteractiveSelection == false
                      ? (context, editableTextState) {
                        final List<ContextMenuButtonItem> buttonItems =
                            editableTextState.contextMenuButtonItems;
                        buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
                          return buttonItem.type == ContextMenuButtonType.cut ||
                              buttonItem.type == ContextMenuButtonType.copy ||
                              buttonItem.type == ContextMenuButtonType.paste ||
                              buttonItem.type == ContextMenuButtonType.selectAll ||
                              buttonItem.type == ContextMenuButtonType.lookUp ||
                              buttonItem.type == ContextMenuButtonType.searchWeb ||
                              buttonItem.type == ContextMenuButtonType.share ||
                              buttonItem.type == ContextMenuButtonType.liveTextInput ||
                              buttonItem.type == ContextMenuButtonType.custom;
                        });
                        return AdaptiveTextSelectionToolbar.buttonItems(
                          anchors: editableTextState.contextMenuAnchors,
                          buttonItems: buttonItems,
                        );
                      }
                      : (context, editableTextState) =>
                          _defaultContextMenuBuilder(context, editableTextState),
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: context.appThemes.transparent,
                labelText: labelText,
                hintText: hintText,
                hintStyle: context.appThemes.regular14.copyWith(color: context.appThemes.ink40),
                labelStyle: context.appThemes.regular14.copyWith(color: context.appThemes.ink40),
                suffixIcon: suffixIcon,
                counterText: counterText,
                counterStyle: counterStyle,
              ),
              onFieldSubmitted: onFieldSubmitted,
            ),
          ),
          Visibility(
            visible: showPrefixIconsDivider == true,
            child: Container(width: 1, height: 26, color: context.appThemes.ink10),
          ),
          Padding(
            padding: EdgeInsetsGeometry.only(left: 4),
            child: InkWell(onTap: onSecondSuffixIconTap, child: secondSuffixIcon),
          ),
        ],
      ),
    );
  }

  Widget _defaultContextMenuBuilder(BuildContext context, EditableTextState editableTextState) {
    if (GetPlatform.isIOS && SystemContextMenu.isSupported(context)) {
      return SystemContextMenu.editableText(editableTextState: editableTextState);
    }
    return AdaptiveTextSelectionToolbar.editableText(editableTextState: editableTextState);
  }
}

enum InputTextStatus { normal, focus, error }
