import 'package:atomic_design/design_system.dart';
import 'package:atomic_design_example/config/shared/widgets/design_system_menu_card.dart';
import 'package:atomic_design_example/feature/home/domain/home_menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Atomic Design')),
      body: GridView.builder(
        padding: EdgeInsets.all(tokens.spacing.small),
        itemCount: HomeMenu.home.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: tokens.spacing.xSmall,
          mainAxisSpacing: tokens.spacing.xSmall,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final menu = HomeMenu.home[index];
          return DesignSystemMenuCard(
            title: menu.title,
            onTap: () => Navigator.pushNamed(context, menu.route),
            image: menu.image,
          );
        },
      ),
    );
  }
}
