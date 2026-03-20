import 'package:atomic_design/atoms/app_colors.dart';
import 'package:atomic_design/molecules/app_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utils.dart';

void main() {
  setUp(() async {
    await initializeTestConfig();
  });

  testWidgets('AppBottomSheet renders title and buttons', (tester) async {
    await pumpTestWidget(
      tester,
      const AppBottomSheet(
        title: 'Title',
        confirmLabel: 'Ok',
        cancelLabel: 'Cancel',
      ),
    );

    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Ok'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('AppBottomSheet danger confirm uses error color', (tester) async {
    await pumpTestWidget(
      tester,
      const AppBottomSheet(
        title: 'Danger',
        confirmLabel: 'Delete',
        isDangerous: true,
      ),
    );

    final button = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, 'Delete'),
    );
    final context = tester.element(find.byType(AppBottomSheet));
    final colors = AppColors.of(context);

    expect(
      button.style?.backgroundColor?.resolve(<WidgetState>{}),
      colors.error,
    );
  });

  // Nota: no se prueba AppBottomSheet.show aquí porque el modal se monta
  // fuera del AppThemeProvider y requiere un árbol de navegación más complejo.
}
