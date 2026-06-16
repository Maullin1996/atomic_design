/// The single entry point for the Atomic Design system.
///
/// Import this library to access all atoms, molecules, organisms, and the
/// configuration layer in one shot:
///
/// ```dart
/// import 'package:atomic_design/design_system.dart';
/// ```
///
/// Before rendering any widget from this library the singleton
/// [AtomicDesignConfig] must be initialised, typically in `main`:
///
/// ```dart
/// await AtomicDesignConfig.initializeFromAsset('assets/config/app_config.json');
/// ```
library;

export 'package:atomic_design/atoms/tokens.dart';
export 'package:atomic_design/config/config.dart';
export 'package:atomic_design/molecules/molecules.dart';
export 'package:atomic_design/organisms/organisms.dart';
