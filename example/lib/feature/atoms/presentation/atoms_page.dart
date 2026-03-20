import 'package:atomic_design/design_system.dart';
import 'package:atomic_design_example/config/shared/widgets/design_system_menu_card.dart';
import 'package:atomic_design_example/feature/atoms/domain/atoms_menu.dart';
import 'package:flutter/material.dart';

class AtomsPage extends StatelessWidget {
  const AtomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Atoms'), leading: BackButton()),
      body: SafeArea(
        child: GridView.builder(
          padding: EdgeInsets.all(tokens.spacing.small),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: tokens.spacing.xSmall,
            mainAxisSpacing: tokens.spacing.xSmall,
            childAspectRatio: 1,
          ),
          itemCount: AtomsMenu.menu.length,
          itemBuilder: (BuildContext context, int index) {
            final menu = AtomsMenu.menu[index];
            return DesignSystemMenuCard(
              title: menu.title,
              icon: menu.icon,
              onTap: () => Navigator.pushNamed(context, menu.route),
            );
          },
        ),
      ),
    );
  }
}
