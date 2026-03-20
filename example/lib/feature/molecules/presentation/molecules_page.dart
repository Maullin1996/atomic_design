import 'package:atomic_design/design_system.dart';
import 'package:atomic_design_example/config/shared/widgets/design_system_menu_card.dart';
import 'package:atomic_design_example/feature/molecules/domain/molecules_menu.dart';
import 'package:flutter/material.dart';

class MoleculesPage extends StatelessWidget {
  const MoleculesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Molecules'), leading: BackButton()),
      body: GridView.builder(
        padding: EdgeInsets.all(tokens.spacing.small),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: tokens.spacing.xSmall,
          mainAxisSpacing: tokens.spacing.xSmall,
          childAspectRatio: 1,
        ),
        itemCount: MoleculesMenu.menu.length,
        itemBuilder: (BuildContext context, int index) {
          final menu = MoleculesMenu.menu[index];
          return DesignSystemMenuCard(
            title: menu.title,
            onTap: () => Navigator.pushNamed(context, menu.route),
            icon: menu.icon,
          );
        },
      ),
    );
  }
}
