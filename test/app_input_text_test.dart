import 'package:atomic_design/atoms/app_input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utils.dart';

void main() {
  setUp(() async {
    await initializeTestConfig();
  });

  testWidgets('AppInputText wires label, hint, and obscureText', (tester) async {
    await pumpTestWidget(
      tester,
      const AppInputText(
        label: 'Correo',
        hint: 'Ingresa tu correo',
        obscureText: true,
      ),
    );

    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.obscureText, isTrue);
    expect(field.decoration?.labelText, 'Correo');
    expect(field.decoration?.hintText, 'Ingresa tu correo');
  });
}
