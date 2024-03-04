import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sales_management/component/btn/approve_btn.dart';
import 'package:sales_management/main.dart';
import 'package:sales_management/utils/constants.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('test create store, verify signup', (tester) async {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarColor: White,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );

      HttpOverrides.global = MyHttpOverrides();

      WidgetsFlutterBinding.ensureInitialized();

      await checkInternetConnection();
      await setupHiveDB();

      // Load app widget.
      await tester.pumpWidget(const MyApp());

      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Verify the counter starts at 0.
      expect(find.text('Sổ Bán Hàng Điện Tử'), findsOneWidget);

      // Finds the floating action button to tap on.
      // final fab = find.byKey(const Key('increment'));

      // Emulate a tap on the floating action button.
      // await tester.tap(fab);

      // Trigger a frame.
      // await tester.pumpAndSettle();
      // Enter 'hi' into the TextField.
      await tester.enterText(find.byType(TextFormField).first, 'test');
      await tester.enterText(find.byType(TextFormField).at(1), '2');

      await tester.pumpAndSettle();

      final signup = find.byType(ApproveBtn);
      await tester.tap(signup);
      await tester.pumpAndSettle();

      // Verify the counter increments by 1.
      expect(find.text('Hôm nay'), findsOneWidget);
    });
  });
}
