import 'package:atomic_design/molecules/app_snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utils.dart';

void main() {
  setUp(() async {
    await initializeTestConfig();
  });

  testWidgets('AppSnackBarContent shows message and action', (tester) async {
    var tapped = false;

    await pumpTestWidget(
      tester,
      AppSnackBarContent(
        type: SnackBarType.success,
        message: 'Saved',
        actionLabel: 'Undo',
        onAction: () => tapped = true,
      ),
    );

    expect(find.text('Saved'), findsOneWidget);
    await tester.tap(find.byType(TextButton));
    expect(tapped, isTrue);
  });

  testWidgets('AppSnackBar.show displays a SnackBar', (tester) async {
    await pumpTestWidget(tester, const SizedBox());

    final context = tester.element(find.byType(SizedBox));
    AppSnackBar.show(
      context,
      type: SnackBarType.info,
      message: 'Hello',
    );
    await tester.pump();

    expect(find.text('Hello'), findsOneWidget);
    final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
    expect(snackBar.behavior, SnackBarBehavior.floating);
  });

  testWidgets('SnackBarType maps to background and icon', (tester) async {
    await pumpTestWidget(tester, const SizedBox());
    final context = tester.element(find.byType(SizedBox));

    expect(SnackBarType.error.background(context), isA<Color>());
    expect(SnackBarType.error.icon(), isA<IconData>());
  });
}
