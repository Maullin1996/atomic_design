import 'package:atomic_design/atoms/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utils.dart';

void main() {
  setUp(() async {
    await initializeTestConfig();
  });

  testWidgets('AppButtons shows loader and disables press when loading', (tester) async {
    await pumpTestWidget(
      tester,
      const AppButtons(
        type: ButtonType.primaryFillButton,
        isLoading: true,
        title: Text('Save'),
      ),
    );

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNull);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
