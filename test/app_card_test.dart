import 'package:atomic_design/molecules/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shimmer/shimmer.dart';

import 'test_utils.dart';

void main() {
  setUp(() async {
    await initializeTestConfig();
  });

  testWidgets('AppCard shows shimmer when loading', (tester) async {
    await pumpTestWidget(
      tester,
      const AppCard(
        isLoading: true,
        child: Text('Content'),
      ),
    );

    expect(find.byKey(const ValueKey('shimmer')), findsOneWidget);
    expect(find.byType(Shimmer), findsOneWidget);
  });

  testWidgets('AppCard shows content when not loading', (tester) async {
    await pumpTestWidget(
      tester,
      const AppCard(
        isLoading: false,
        child: Text('Content'),
      ),
    );

    expect(find.text('Content'), findsOneWidget);
    expect(find.byKey(const ValueKey('shimmer')), findsNothing);
  });
}
