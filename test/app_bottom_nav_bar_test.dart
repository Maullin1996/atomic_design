import 'package:atomic_design/organisms/app_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utils.dart';

void main() {
  setUp(() async {
    await initializeTestConfig();
  });

  testWidgets('AppBottomNavBar renders items and calls onTap', (tester) async {
    var tappedIndex = -1;

    await pumpTestWidget(
      tester,
      AppBottomNavBar(
        items: const [
          BottomNavItem(icon: Icons.home, label: 'Home'),
          BottomNavItem(icon: Icons.search, label: 'Search'),
        ],
        currentIndex: 0,
        onTap: (index) => tappedIndex = index,
      ),
    );

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);

    await tester.tap(find.text('Search'));
    await tester.pump();
    expect(tappedIndex, 1);
  });
}
