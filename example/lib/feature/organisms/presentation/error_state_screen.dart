import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

class ErrorStateScreen extends StatelessWidget {
  const ErrorStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Error State'), leading: BackButton()),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(tokens.spacing.small),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Widget con Imagen',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: tokens.spacing.xSmall),
                  Container(
                    constraints: BoxConstraints(maxWidth: 300),
                    padding: EdgeInsets.all(tokens.spacing.small),
                    decoration: BoxDecoration(
                      color: AppColors.of(context).surfaceLow,
                      borderRadius: BorderRadius.circular(tokens.radius.medium),
                    ),
                    child: AppStateWidget(
                      title: 'Ejemplo de mensaje para una lista vacía',
                      image: 'assets/images/error.png',
                      buttonChild: Text('Recargar'),
                      type: AppStateType.error,
                      onPressed: () {},
                      widthImage: 200,
                      heightImage: 200,
                    ),
                  ),
                  SizedBox(height: tokens.spacing.medium),
                  Text(
                    'Widget con Imagen',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: tokens.spacing.xSmall),
                  Container(
                    constraints: BoxConstraints(maxWidth: 300),
                    padding: EdgeInsets.all(tokens.spacing.small),
                    decoration: BoxDecoration(
                      color: AppColors.of(context).surfaceLow,
                      borderRadius: BorderRadius.circular(tokens.radius.medium),
                    ),
                    child: AppStateWidget(
                      title: 'Ejemplo de mensaje para una lista vacía',
                      icon: Icons.error,
                      iconColor: AppColors.of(context).error,
                      buttonChild: Text('Recargar'),
                      type: AppStateType.error,
                      onPressed: () {},
                      iconSize: 150,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
