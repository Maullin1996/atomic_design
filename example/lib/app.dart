import 'package:atomic_design/atoms/tokens.dart';
import 'package:flutter/material.dart';
import 'package:atomic_design_example/config/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppThemeProvider(
      child: MaterialApp(
        title: 'Atomic Design',
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.home,
        theme: AppThemes.light,
        darkTheme: AppThemes.dark,
        themeMode: ThemeMode.system,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
