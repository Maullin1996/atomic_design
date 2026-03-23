import 'package:atomic_design/atoms/app_tokens.dart';
import 'package:atomic_design_example/config/shared/widgets/design_system_menu_card.dart';
import 'package:atomic_design_example/feature/templates/domain/templates_menu.dart';
import 'package:flutter/material.dart';

class TemplatesPage extends StatelessWidget {
  const TemplatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Templates'), leading: BackButton()),
      body: SafeArea(
        child: GridView.builder(
          padding: EdgeInsets.all(tokens.spacing.small),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: tokens.spacing.xSmall,
            mainAxisSpacing: tokens.spacing.xSmall,
            childAspectRatio: 1,
          ),
          itemCount: TemplatesMenu.menu.length,
          itemBuilder: (BuildContext context, int index) {
            final menu = TemplatesMenu.menu[index];
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
