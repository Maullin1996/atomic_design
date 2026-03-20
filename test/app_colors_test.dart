import 'package:atomic_design/atoms/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utils.dart';

void main() {
  setUp(() async {
    await initializeTestConfig();
  });

  testWidgets('AppColors resolves primary color from config', (tester) async {
    late Color color;

    await pumpTestWidget(
      tester,
      Builder(
        builder: (context) {
          color = AppColors.of(context).primary;
          return const SizedBox();
        },
      ),
    );

    expect(color, parseHexColor('#3366FF'));
  });
}
