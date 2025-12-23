// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabItem extends StatelessWidget {
  final String title;
  final int? count;

  const TabItem({super.key, required this.title, this.count});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
          (count?.isGreaterThan(0) == true)
              ? Container(
                  margin: const EdgeInsetsDirectional.only(start: 5),
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(color: Colors.grey.shade200, shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      (count?.isGreaterThan(9) == true) ? "9+" : count.toString(),
                      style: const TextStyle(color: Colors.black54, fontSize: 10),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              : const SizedBox(width: 0, height: 0),
        ],
      ),
    );
  }
}
