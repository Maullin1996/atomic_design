import 'package:atomic_design/atoms/app_tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utils.dart';

void main() {
  setUp(() async {
    await initializeTestConfig();
  });

  testWidgets('AppTokens resolves responsive spacing for width', (tester) async {
    late AppTokens tokens;

    await pumpTestWidget(
      tester,
      Builder(
        builder: (context) {
          tokens = AppTokens.of(context);
          return const SizedBox();
        },
      ),
      size: const Size(350, 800),
    );

    expect(tokens.spacing.xSmall, 2);
    expect(tokens.radius.small, 2);
  });

  testWidgets('AppTokens switches to medium tokens on wider screens', (tester) async {
    late AppTokens tokens;

    await pumpTestWidget(
      tester,
      Builder(
        builder: (context) {
          tokens = AppTokens.of(context);
          return const SizedBox();
        },
      ),
      size: const Size(500, 800),
    );

    expect(tokens.spacing.xSmall, 6);
    expect(tokens.radius.small, 6);
  });
}
