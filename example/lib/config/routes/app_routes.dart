import 'package:atomic_design_example/feature/atoms/presentation/buttons_screen.dart';
import 'package:atomic_design_example/feature/atoms/presentation/colors_screen.dart';
import 'package:atomic_design_example/feature/atoms/presentation/icons_screen.dart';
import 'package:atomic_design_example/feature/atoms/presentation/input_text_screen.dart';
import 'package:atomic_design_example/feature/atoms/presentation/spacing_radius_screen.dart';
import 'package:atomic_design_example/feature/atoms/presentation/typography_screen.dart';
import 'package:atomic_design_example/feature/molecules/presentation/bottom_sheet_screen.dart';
import 'package:atomic_design_example/feature/molecules/presentation/custom_card_screen.dart';
import 'package:atomic_design_example/feature/molecules/presentation/dialog_screen.dart';
import 'package:atomic_design_example/feature/molecules/presentation/search_bar_screen.dart';
import 'package:atomic_design_example/feature/molecules/presentation/snack_bar_message_screen.dart';
import 'package:atomic_design_example/feature/organisms/presentation/bottom_nav_bar_screen.dart';
import 'package:atomic_design_example/feature/organisms/presentation/card_list_screen.dart';
import 'package:atomic_design_example/feature/organisms/presentation/drawer_screen.dart';
import 'package:atomic_design_example/feature/organisms/presentation/empty_state_screen.dart';
import 'package:atomic_design_example/feature/organisms/presentation/error_state_screen.dart';
import 'package:atomic_design_example/feature/organisms/presentation/grid_view_screen.dart';
import 'package:atomic_design_example/feature/organisms/presentation/loging_form_screen.dart';
import 'package:atomic_design_example/feature/organisms/presentation/search_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:atomic_design_example/feature/atoms/presentation/atoms_page.dart';
import 'package:atomic_design_example/feature/home/presentation/home_page.dart';
import 'package:atomic_design_example/feature/molecules/presentation/molecules_page.dart';
import 'package:atomic_design_example/feature/organisms/presentation/organisms_page.dart';

abstract class AppRoutes {
  static const String home = '/';
  // Atoms
  static const String atoms = '/atoms';
  static const String colors = '/colors';
  static const String typography = 'typography';
  static const String buttons = '/buttons';
  static const String icons = '/icons';
  static const String spacing = '/spacing-radius';
  static const String inputText = '/inputText';

  // Molecules
  static const String molecules = '/molecules';
  static const String searchBar = '/searchbar';
  static const String customCard = '/customcard';
  static const String snackBar = '/snackBarMessage';
  static const String dialogs = '/dialogs';
  static const String bottomSheet = '/bottomSheet';

  // Organisms
  static const String organisms = '/organisms';
  static const String searchResults = '/search_results';
  static const String cardList = '/cardList';
  static const String emptyState = '/emptyState';
  static const String errorState = '/errorState';
  static const String drawer = '/drawer';
  static const String bottomNavBar = '/bottomNavBar';
  static const String gridView = '/gridView';
  static const String loginForm = '/logForm';

  static Map<String, WidgetBuilder> get routes => {
    home: (context) => const HomePage(),
    atoms: (context) => const AtomsPage(),
    molecules: (context) => const MoleculesPage(),
    organisms: (context) => const OrganismsPage(),
    colors: (context) => const ColorsScreen(),
    typography: (context) => const TypographyScreen(),
    buttons: (context) => const ButtonsScreen(),
    icons: (context) => const IconsScreen(),
    spacing: (context) => const SpacingRadiusScreen(),
    inputText: (context) => const IconsScreen(),
    searchBar: (context) => const SearchBarScreen(),
    customCard: (context) => const CustomCardScreen(),
    snackBar: (context) => const SnackBarMessageScreen(),
    dialogs: (context) => const DialogScreen(),
    bottomSheet: (context) => const BottomSheetScreen(),
    searchResults: (context) => const SearchResultScreen(),
    cardList: (context) => const CardListScreen(),
    emptyState: (context) => const EmptyStateScreen(),
    errorState: (context) => const ErrorStateScreen(),
    drawer: (context) => const DrawerScreen(),
    bottomNavBar: (context) => const BottomNavBarScreen(),
    gridView: (context) => const GridViewScreen(),
    loginForm: (context) => const LogingFormScreen(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case atoms:
        return MaterialPageRoute(builder: (_) => const AtomsPage());
      case molecules:
        return MaterialPageRoute(builder: (_) => const MoleculesPage());
      case organisms:
        return MaterialPageRoute(builder: (_) => const OrganismsPage());
      case colors:
        return MaterialPageRoute(builder: (_) => const ColorsScreen());
      case typography:
        return MaterialPageRoute(builder: (_) => const TypographyScreen());
      case buttons:
        return MaterialPageRoute(builder: (_) => const ButtonsScreen());
      case icons:
        return MaterialPageRoute(builder: (_) => const IconsScreen());
      case spacing:
        return MaterialPageRoute(builder: (_) => const SpacingRadiusScreen());
      case inputText:
        return MaterialPageRoute(builder: (_) => const InputTextScreen());
      case searchBar:
        return MaterialPageRoute(builder: (_) => const SearchBarScreen());
      case customCard:
        return MaterialPageRoute(builder: (_) => const CustomCardScreen());
      case snackBar:
        return MaterialPageRoute(builder: (_) => const SnackBarMessageScreen());
      case dialogs:
        return MaterialPageRoute(builder: (_) => const DialogScreen());
      case bottomSheet:
        return MaterialPageRoute(builder: (_) => const BottomSheetScreen());
      case searchResults:
        return MaterialPageRoute(builder: (_) => const SearchResultScreen());
      case cardList:
        return MaterialPageRoute(builder: (_) => const CardListScreen());
      case errorState:
        return MaterialPageRoute(builder: (_) => const ErrorStateScreen());
      case emptyState:
        return MaterialPageRoute(builder: (_) => const EmptyStateScreen());
      case drawer:
        return MaterialPageRoute(builder: (_) => const DrawerScreen());
      case bottomNavBar:
        return MaterialPageRoute(builder: (_) => const BottomNavBarScreen());
      case gridView:
        return MaterialPageRoute(builder: (_) => const GridViewScreen());
      case loginForm:
        return MaterialPageRoute(builder: (_) => const LogingFormScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
