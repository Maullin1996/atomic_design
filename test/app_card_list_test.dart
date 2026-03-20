import 'package:atomic_design/organisms/app_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utils.dart';

void main() {
  setUp(() async {
    await initializeTestConfig();
  });

  testWidgets('AppCardList shows list state', (tester) async {
    await pumpTestWidget(
      tester,
      AppCardList(
        type: CardListType.list,
        emptyWidget: const Text('Empty'),
        errorWidget: const Text('Error'),
        elementsList: const Text('List'),
      ),
    );

    expect(find.byKey(const ValueKey('list')), findsOneWidget);
    expect(find.text('List'), findsOneWidget);
  });

  testWidgets('AppCardList shows error state', (tester) async {
    await pumpTestWidget(
      tester,
      AppCardList(
        type: CardListType.error,
        emptyWidget: const Text('Empty'),
        errorWidget: const Text('Error'),
        elementsList: const Text('List'),
      ),
    );

    expect(find.byKey(const ValueKey('error')), findsOneWidget);
    expect(find.text('Error'), findsOneWidget);
  });

  testWidgets('AppCardList shows empty state', (tester) async {
    await pumpTestWidget(
      tester,
      AppCardList(
        type: CardListType.empty,
        emptyWidget: const Text('Empty'),
        errorWidget: const Text('Error'),
        elementsList: const Text('List'),
      ),
    );

    expect(find.byKey(const ValueKey('empty')), findsOneWidget);
    expect(find.text('Empty'), findsOneWidget);
  });

  testWidgets('AppCardList shows loading list', (tester) async {
    await pumpTestWidget(
      tester,
      AppCardList(
        type: CardListType.loading,
        emptyWidget: const Text('Empty'),
        errorWidget: const Text('Error'),
        elementsList: const Text('List'),
      ),
    );

    expect(find.byKey(const ValueKey('loading')), findsOneWidget);
  });
}
