import 'package:atomic_design/atoms/app_themes.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utils.dart';

void main() {
  setUp(() async {
    await initializeTestConfig();
  });

  test('AppThemes.light uses config colors and typography', () {
    final theme = AppThemes.light;

    expect(theme.colorScheme.primary, parseHexColor('#3366FF'));
    expect(theme.textTheme.displayLarge?.fontFamily, 'TestFont');
  });
}
