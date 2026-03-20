import 'package:atomic_design/atoms/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utils.dart';

void main() {
  setUp(() async {
    await initializeTestConfig();
  });

  testWidgets('AppText applies custom color and overflow', (tester) async {
    const color = Color(0xFF123456);

    await pumpTestWidget(
      tester,
      const AppText.h1(
        'Hello',
        color: color,
      ),
    );

    final text = tester.widget<Text>(find.text('Hello'));
    expect(text.style?.color, color);
    expect(text.overflow, TextOverflow.ellipsis);
  });
}
