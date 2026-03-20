import 'package:atomic_design/organisms/app_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utils.dart';

void main() {
  setUp(() async {
    await initializeTestConfig();
  });

  testWidgets('AppGridView shows list state', (tester) async {
    await pumpTestWidget(
      tester,
      AppGridView(
        type: GridViewType.list,
        emptyWidget: const Text('Empty'),
        errorWidget: const Text('Error'),
        elementsList: const Text('Grid'),
      ),
    );

    expect(find.byKey(const ValueKey('list')), findsOneWidget);
    expect(find.text('Grid'), findsOneWidget);
  });

  testWidgets('AppGridView shows empty state', (tester) async {
    await pumpTestWidget(
      tester,
      AppGridView(
        type: GridViewType.empty,
        emptyWidget: const Text('Empty'),
        errorWidget: const Text('Error'),
        elementsList: const Text('Grid'),
      ),
    );

    expect(find.byKey(const ValueKey('empty')), findsOneWidget);
    expect(find.text('Empty'), findsOneWidget);
  });

  testWidgets('AppGridView shows error state', (tester) async {
    await pumpTestWidget(
      tester,
      AppGridView(
        type: GridViewType.error,
        emptyWidget: const Text('Empty'),
        errorWidget: const Text('Error'),
        elementsList: const Text('Grid'),
      ),
    );

    expect(find.text('Error'), findsOneWidget);
  });

  testWidgets('AppGridView shows loading grid', (tester) async {
    await pumpTestWidget(
      tester,
      AppGridView(
        type: GridViewType.loading,
        emptyWidget: const Text('Empty'),
        errorWidget: const Text('Error'),
        elementsList: const Text('Grid'),
      ),
    );

    expect(find.byKey(const ValueKey('loading')), findsOneWidget);
  });
}
