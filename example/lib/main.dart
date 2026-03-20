import 'package:flutter/material.dart';
import 'package:atomic_design_example/app.dart';
import 'package:atomic_design/design_system.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AtomicDesignConfig.initializeFromAsset('assets/config/app_config.json');
  runApp(const MyApp());
}
