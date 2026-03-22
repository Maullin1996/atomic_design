import 'package:atomic_design/atoms/app_themes.dart';
import 'package:atomic_design/atoms/app_tokens.dart';
import 'package:atomic_design/organisms/app_drawe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utils.dart';

Future<void> pumpDrawerTest(WidgetTester tester, AppDrawer drawer) async {
  await tester.binding.setSurfaceSize(const Size(400, 800));
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await tester.pumpWidget(
    MaterialApp(
      theme: AppThemes.light,
      home: AppThemeProvider(
        child: Scaffold(
          drawer: drawer,
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                child: const Text('Open Drawer'),
              );
            },
          ),
        ),
      ),
    ),
  );

  await tester.tap(find.text('Open Drawer'));
  await tester.pumpAndSettle();
}

void main() {
  setUp(() async {
    await initializeTestConfig();
  });

  testWidgets('AppDrawer shows header and items', (tester) async {
    await pumpDrawerTest(
      tester,
      AppDrawer(
        userName: 'Juan Perez',
        userEmail: 'juan@mail.com',
        items: [DrawerItem(icon: Icons.home, label: 'Inicio', onTap: () {})],
      ),
    );

    expect(find.text('Juan Perez'), findsOneWidget);
    expect(find.text('juan@mail.com'), findsOneWidget);
    expect(find.text('Inicio'), findsOneWidget);
  });

  testWidgets('AppDrawer calls onTap for item', (tester) async {
    var tapped = false;

    await pumpDrawerTest(
      tester,
      AppDrawer(
        items: [
          DrawerItem(
            icon: Icons.home,
            label: 'Inicio',
            onTap: () => tapped = true,
          ),
        ],
      ),
    );

    await tester.tap(find.text('Inicio'));
    await tester.pumpAndSettle();

    expect(tapped, isTrue);
  });

  testWidgets('AppDrawer shows logout action when provided', (tester) async {
    var tapped = false;

    await pumpDrawerTest(
      tester,
      AppDrawer(items: const [], onLogout: () => tapped = true),
    );

    expect(find.text('Cerrar sesión'), findsOneWidget);
    await tester.tap(find.text('Cerrar sesión'));
    await tester.pumpAndSettle();
    expect(tapped, isTrue);
  });
}
