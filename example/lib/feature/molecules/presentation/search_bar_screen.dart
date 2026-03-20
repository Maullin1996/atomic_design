import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

class SearchBarScreen extends StatelessWidget {
  const SearchBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final controller = TextEditingController();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text('Search Bar'), leading: BackButton()),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(tokens.spacing.smallMedium),
          child: Container(
            padding: EdgeInsets.all(tokens.spacing.small),
            decoration: BoxDecoration(
              color: AppColors.of(context).surfaceLow,
              borderRadius: BorderRadius.circular(tokens.radius.medium),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SearchBarMolecule',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: tokens.spacing.small),
                Text(
                  'Molécula para captura de texto de búsqueda. '
                  'No maneja submit ni renderiza resultados.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: tokens.spacing.medium),

                AppSearchBar(controller: controller, onChanged: (_) {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
