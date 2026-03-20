import 'package:atomic_design/molecules/app_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utils.dart';

void main() {
  setUp(() async {
    await initializeTestConfig();
  });

  testWidgets('AppSearchBar wires hint and onChanged', (tester) async {
    var value = '';

    await pumpTestWidget(
      tester,
      AppSearchBar(
        hintText: 'Buscar',
        onChanged: (v) => value = v,
      ),
    );

    expect(find.byIcon(Icons.search_rounded), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'hola');
    expect(value, 'hola');

    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.decoration?.labelText, 'Buscar');
  });
}
