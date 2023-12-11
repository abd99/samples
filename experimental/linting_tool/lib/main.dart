// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:linting_tool/app.dart';
import 'package:linting_tool/model/profile.dart';
import 'package:linting_tool/model/rule.dart';
import 'package:window_size/window_size.dart';

Future<void> main() async {
  /// Initialize Hive DB.
  await Hive.initFlutter();

  /// Register adapters for [Rule] and [RulesProfile]
  /// so that their objects can be directly saved to the DB.
  Hive.registerAdapter(RuleAdapter());
  Hive.registerAdapter(RulesProfileAdapter());

  /// Open a [LazyBox] to retrieve data from it
  await Hive.openLazyBox<RulesProfile>('rules_profile');

  setWindowMinSize(const Size(600, 600));

  if (Platform.isWindows) {
    doWhenWindowReady(() {
      const initialSize = Size(600, 450);
      appWindow.minSize = initialSize;
      appWindow.size = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.show();
    });
  }

  runApp(const LintingTool());
}
