// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:testing_app/main.dart';

void main() {
  group('Testing App Driver Tests', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('Finding an item in the list', (tester) async {
      await tester.pumpWidget(TestingApp());

      // Create finder that are used multiple times.
      final itemFinder = find.byKey(ValueKey('text_25'));

      // Scroll until the item to be found appears.
      await tester.scrollUntilVisible(
        itemFinder,
        500.0,
      );

      // Check if the item contains the correct text.
      expect(tester.widget<Text>(itemFinder).data, 'Item 25');
    });

    testWidgets('Testing IconButtons', (tester) async {
      await tester.pumpWidget(TestingApp());

      // Create a finder for the icon.
      final iconFinder = find.byKey(ValueKey('icon_0'));

      // Tap on the icon.
      await tester.tap(iconFinder);
      await tester.pumpAndSettle(Duration(seconds: 1));

      // Verify if appropriate message appears.
      expect(find.text('Added to favorites.'), findsOneWidget);

      // Tap on the icon again.
      await tester.tap(iconFinder);
      await tester.pumpAndSettle(Duration(seconds: 1));

      // Verify if appropriate message appears.
      expect(find.text('Removed from favorites.'), findsOneWidget);
      await tester.pumpAndSettle(Duration(seconds: 1));
    });

    testWidgets('Verifying whether item gets added to favorites',
        (tester) async {
      await tester.pumpWidget(TestingApp());

      // Add item to favorites.
      await tester.tap(find.byKey(ValueKey('icon_5')));
      await tester.pumpAndSettle(Duration(seconds: 1));

      // Tap on the favorites button on the AppBar.
      // The Favorites List should appear.
      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();

      // Check if the added item has appeared in the list.
      expect(tester.widget<Text>(find.byKey(ValueKey('favorites_text_5'))).data,
          equals('Item 5'));
    });

    testWidgets('Testing remove button', (tester) async {
      await tester.pumpWidget(TestingApp());

      // Add item to favorites.
      await tester.tap(find.byKey(ValueKey('icon_5')));
      await tester.pumpAndSettle(Duration(seconds: 1));

      // Navigate to Favorites screen.
      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();

      // Tap on the remove icon.
      await tester.tap(find.byKey(ValueKey('remove_icon_5')));
      await tester.pumpAndSettle();

      // Verify if it disappears.
      expect(find.text('Item 5'), findsNothing);

      // Verify if appropriate message appears.
      expect(find.text('Removed from favorites.'), findsOneWidget);
    });
  });
}