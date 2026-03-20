import 'package:atomic_design/design_system.dart' show AppTokens;
import 'package:atomic_design_example/config/shared/widgets/design_system_menu_card.dart';
import 'package:atomic_design_example/feature/organisms/domain/organisms_menu.dart';
import 'package:flutter/material.dart';

class OrganismsPage extends StatelessWidget {
  const OrganismsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Organismos'), leading: BackButton()),
      body: SafeArea(
        child: GridView.builder(
          padding: EdgeInsets.all(tokens.spacing.small),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: tokens.spacing.xSmall,
            mainAxisSpacing: tokens.spacing.xSmall,
            childAspectRatio: 1,
          ),
          itemCount: OrganismsMenu.menu.length,
          itemBuilder: (BuildContext context, int index) {
            final menu = OrganismsMenu.menu[index];
            return DesignSystemMenuCard(
              title: menu.title,
              onTap: () => Navigator.pushNamed(context, menu.route),
              icon: menu.icon,
            );
          },
        ),
      ),
    );
  }
}
