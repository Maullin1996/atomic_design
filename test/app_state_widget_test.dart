import 'package:atomic_design/atoms/app_colors.dart';
import 'package:atomic_design/organisms/app_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utils.dart';

void main() {
  setUp(() async {
    await initializeTestConfig();
  });

  testWidgets('AppStateWidget shows icon and title', (tester) async {
    await pumpTestWidget(
      tester,
      AppStateWidget(
        type: AppStateType.empty,
        icon: Icons.inbox,
        title: 'Sin datos',
        buttonChild: const Text('Reintentar'),
        onPressed: () {},
      ),
    );

    expect(find.byIcon(Icons.inbox), findsOneWidget);
    expect(find.text('Sin datos'), findsOneWidget);
    expect(find.text('Reintentar'), findsOneWidget);
  });

  testWidgets('AppStateWidget error uses error color in title', (tester) async {
    await pumpTestWidget(
      tester,
      AppStateWidget(
        type: AppStateType.error,
        icon: Icons.error,
        title: 'Error',
        buttonChild: const Text('Reintentar'),
        onPressed: () {},
      ),
    );

    final context = tester.element(find.byType(AppStateWidget));
    final colors = AppColors.of(context);
    final text = tester.widget<Text>(find.text('Error'));
    expect(text.style?.color, colors.error);
  });
}
