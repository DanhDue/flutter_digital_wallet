// Copyright (c) 2026, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:d3_wallet/generated/assets.gen.dart';
import 'package:d3_wallet/generated/locales.g.dart';
import 'package:d3_wallet/styles/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrendsSearchBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(String)? onChanged;
  final VoidCallback? onSearchTap;
  final VoidCallback? onMicTap;
  final Function(String)? onHistoryTap;
  final List<String>? history;
  final Function(bool)? onFocusChanged;

  const TrendsSearchBar({
    super.key,
    this.onChanged,
    this.onSearchTap,
    this.onMicTap,
    this.onHistoryTap,
    this.history,
    this.onFocusChanged,
  });

  @override
  State<TrendsSearchBar> createState() => _TrendsSearchBarState();

  @override
  Size get preferredSize => const Size.fromHeight(76);
}

class _TrendsSearchBarState extends State<TrendsSearchBar> with SingleTickerProviderStateMixin {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  void _onTextChanged() {
    setState(() {});
  }

  void _onFocusChanged() {
    setState(() {});
    widget.onFocusChanged?.call(_focusNode.hasFocus);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _focusNode.removeListener(_onFocusChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isExpanded = _focusNode.hasFocus;

    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Container(
        margin: const .symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: context.appThemes.white,
          borderRadius: .circular(24),
          boxShadow: [
            BoxShadow(
              color: context.appThemes.ink100.withValues(alpha: 0.18),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: .circular(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const .symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  children: [
                    Assets.images.icSearch.svg(
                      width: 20,
                      height: 20,
                      colorFilter: .mode(context.appThemes.ink100, .srcIn),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        onChanged: widget.onChanged,
                        onTap: widget.onSearchTap,
                        decoration: InputDecoration(
                          hintText: LocaleKeys.trendsSearchHint.tr,
                          hintStyle: context.appThemes.regular16.copyWith(
                            color: context.appThemes.ink40,
                          ),
                          border: .none,
                          enabledBorder: .none,
                          focusedBorder: .none,
                          isDense: true,
                          contentPadding: const .symmetric(vertical: 11),
                        ),
                        style: context.appThemes.regular16.copyWith(
                          color: context.appThemes.ink100,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (_controller.text.isNotEmpty)
                      InkWell(
                        onTap: () {
                          _controller.clear();
                          widget.onChanged?.call("");
                          setState(() {});
                        },
                        child: Padding(
                          padding: const .all(4),
                          child: Assets.images.icClear.svg(
                            width: 16,
                            height: 16,
                            colorFilter: .mode(context.appThemes.ink60, .srcIn),
                          ),
                        ),
                      ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: widget.onMicTap,
                      child: Padding(
                        padding: const .all(4),
                        child: Icon(
                          Icons.mic_rounded,
                          color: context.appThemes.trueBlue,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 1,
                width: isExpanded ? MediaQuery.of(context).size.width : 0,
                color: context.appThemes.trueBlue,
              ),
              if (isExpanded)
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: widget.history == null || widget.history!.isEmpty
                        ? Container(
                            height: 100,
                            alignment: Alignment.center,
                            child: Text(
                              LocaleKeys.trendsNoRecentSearches.tr,
                              style: context.appThemes.regular14.copyWith(
                                color: context.appThemes.ink40,
                              ),
                            ),
                          )
                        : Column(
                            crossAxisAlignment: .start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const .only(left: 16, top: 12, bottom: 4),
                                child: Text(
                                  LocaleKeys.trendsRecentSearches.tr,
                                  style: context.appThemes.bold12.copyWith(
                                    color: context.appThemes.ink100,
                                  ),
                                ),
                              ),
                              ListView.builder(
                                padding: .zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.history!.length,
                                itemBuilder: (context, index) {
                                  final item = widget.history![index];
                                  return ListTile(
                                    leading: const Icon(Icons.history, size: 18),
                                    title: Text(
                                      item,
                                      style: context.appThemes.regular14.copyWith(
                                        color: context.appThemes.ink100,
                                      ),
                                    ),
                                    onTap: () {
                                      _controller.text = item;
                                      widget.onChanged?.call(item);
                                      widget.onHistoryTap?.call(item);
                                      _focusNode.unfocus();
                                    },
                                    dense: true,
                                  );
                                },
                              ),
                            ],
                          ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
