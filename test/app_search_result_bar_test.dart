import 'package:atomic_design/organisms/app_search_result_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utils.dart';

void main() {
  setUp(() async {
    await initializeTestConfig();
  });

  testWidgets('AppResultSearchBar shows empty state when no child', (tester) async {
    await pumpTestWidget(
      tester,
      const AppResultSearchBar(),
    );

    expect(find.byKey(const ValueKey('empty')), findsOneWidget);
    expect(find.byKey(const ValueKey('results')), findsNothing);
  });

  testWidgets('AppResultSearchBar shows results when child provided', (tester) async {
    await pumpTestWidget(
      tester,
      const AppResultSearchBar(
        child: Text('Result'),
      ),
    );

    expect(find.byKey(const ValueKey('results')), findsOneWidget);
    expect(find.text('Result'), findsOneWidget);
  });
}
