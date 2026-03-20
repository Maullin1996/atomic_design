import 'package:atomic_design_example/config/routes/app_routes.dart';
import 'package:atomic_design_example/config/shared/classes/menu_structure.dart';

abstract class HomeMenu {
  static const List<MenuStructure> home = [
    MenuStructure(
      title: 'Atoms',
      image: 'assets/images/atoms.png',
      route: AppRoutes.atoms,
    ),
    MenuStructure(
      title: 'Molecules',
      image: 'assets/images/molecules.png',
      route: AppRoutes.molecules,
    ),
    MenuStructure(
      title: 'Organisms',
      image: 'assets/images/organisms.png',
      route: AppRoutes.organisms,
    ),
  ];
}
