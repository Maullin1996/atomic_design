import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

class GridViewScreen extends StatefulWidget {
  const GridViewScreen({super.key});

  @override
  State<GridViewScreen> createState() => _GridViewScreenState();
}

class _GridViewScreenState extends State<GridViewScreen> {
  GridViewType type = GridViewType.list;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Grid View'), leading: BackButton()),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  AppButtons(
                    type: ButtonType.primaryTextButton,
                    onPressed: () => setState(() => type = GridViewType.list),
                    title: Text(
                      'Lista',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(color: colors.primary),
                    ),
                  ),
                  AppButtons(
                    type: ButtonType.primaryTextButton,
                    onPressed: () => setState(() => type = GridViewType.error),
                    title: Text(
                      'Error',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(color: colors.primary),
                    ),
                  ),
                  AppButtons(
                    type: ButtonType.primaryTextButton,
                    onPressed: () => setState(() => type = GridViewType.empty),
                    title: Text(
                      'Vacía',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(color: colors.primary),
                    ),
                  ),
                  AppButtons(
                    type: ButtonType.primaryTextButton,
                    onPressed: () =>
                        setState(() => type = GridViewType.loading),
                    title: Text(
                      'Cargando',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(color: colors.primary),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: AppGridView(
                type: type,
                itemCount: 20,
                childAspectRatio: 0.75,
                itemBuilder: (_, __) => const _GridCard(),
                emptyWidget: AppStateWidget(
                  type: AppStateType.empty,
                  title: 'Todavía no hay elementos',
                  buttonChild: const Text('Agregar elemento'),
                  onPressed: () {},
                  image: 'assets/images/empty_icon.png',
                ),
                errorWidget: AppStateWidget(
                  type: AppStateType.error,
                  title: 'Error al cargar los elementos',
                  buttonChild: const Text('Recargar'),
                  onPressed: () {},
                  image: 'assets/images/error.png',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GridCard extends StatelessWidget {
  const _GridCard();

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final colors = AppColors.of(context);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(tokens.radius.medium),
                child: AppNetworkImage(
                  url:
                      'https://img.freepik.com/fotos-premium/gato-traje-negocios-profesional-felino_512668-16753.jpg',
                  fit: BoxFit.cover,
                  widthImage: double.infinity,
                  heightImage: double.infinity,
                  errorWidget: Icon(
                    AppIcons.brokenImage,
                    color: colors.textDisabled,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(tokens.spacing.xSmall),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppText.h6(
                    'Michi Credencial',
                    color: colors.primary,
                    maxLines: 1,
                  ),
                  AppText.label(
                    'Nació en Bello el 18 de noviembre de 2020, se destaca por su curiosidad.',
                    color: colors.textSecondary,
                    maxLines: 2,
                  ),
                  AppText.caption(
                    'Ver más →',
                    color: colors.primary,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
