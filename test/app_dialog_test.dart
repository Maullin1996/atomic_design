import 'package:atomic_design/atoms/app_colors.dart';
import 'package:atomic_design/molecules/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utils.dart';

void main() {
  setUp(() async {
    await initializeTestConfig();
  });

  testWidgets('AppDialog uses danger styling for confirm button', (tester) async {
    await pumpTestWidget(
      tester,
      const AppDialog(
        title: 'Eliminar',
        confirmLabel: 'Eliminar',
        isDangerous: true,
      ),
    );

    final button = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, 'Eliminar'),
    );

    final context = tester.element(find.byType(AppDialog));
    final colors = AppColors.of(context);

    expect(
      button.style?.backgroundColor?.resolve(<WidgetState>{}),
      colors.error,
    );
  });
}
