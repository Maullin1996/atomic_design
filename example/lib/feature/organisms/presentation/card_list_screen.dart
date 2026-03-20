import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

class CardListScreen extends StatefulWidget {
  const CardListScreen({super.key});

  @override
  State<CardListScreen> createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  CardListType type = CardListType.list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart List'), leading: BackButton()),
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
                    onPressed: () {
                      type = CardListType.list;
                      setState(() {});
                    },
                    title: Text(
                      'Lista',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(color: AppColors.of(context).primary),
                    ),
                  ),
                  AppButtons(
                    type: ButtonType.primaryTextButton,
                    onPressed: () {
                      setState(() {});
                      type = CardListType.error;
                    },
                    title: Text(
                      'Error',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(color: AppColors.of(context).primary),
                    ),
                  ),
                  AppButtons(
                    type: ButtonType.primaryTextButton,
                    onPressed: () {
                      type = CardListType.empty;
                      setState(() {});
                    },
                    title: Text(
                      'Vacía',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(color: AppColors.of(context).primary),
                    ),
                  ),
                  AppButtons(
                    type: ButtonType.primaryTextButton,
                    onPressed: () {
                      type = CardListType.loading;
                      setState(() {});
                    },
                    title: Text(
                      'Cargando',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(color: AppColors.of(context).primary),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: AppCardList(
                elementsList: _ElementsList(),
                emptyWidget: AppStateWidget(
                  title: 'Todavía no tiene Elementos',
                  type: AppStateType.empty,
                  image: 'assets/images/empty_icon.png',
                  onPressed: () {},
                  buttonChild: Text('Add Element'),
                ),
                errorWidget: AppStateWidget(
                  onPressed: () {},
                  type: AppStateType.error,
                  image: 'assets/images/error.png',
                  title: 'Error Al Cargar Los Elementos',
                  buttonChild: Text('Recargar'),
                ),
                type: type,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ElementsList extends StatelessWidget {
  const _ElementsList();

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return ListView.separated(
      padding: EdgeInsets.all(tokens.spacing.small),
      itemCount: 20,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: tokens.spacing.xSmall);
      },
      itemBuilder: (BuildContext context, int index) {
        return _ContentCard();
      },
    );
  }
}

class _ContentCard extends StatelessWidget {
  const _ContentCard();

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 250),
      child: AppCard(
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // imagen ocupa todo el alto
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(tokens.radius.medium),
                topLeft: Radius.circular(tokens.radius.medium),
              ),
              child: AppNetworkImage(
                url:
                    'https://img.freepik.com/fotos-premium/gato-traje-negocios-profesional-felino_512668-16753.jpg',
                errorWidget: Icon(AppIcons.brokenImage),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: tokens.spacing.small),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Michi Credencial',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(color: AppColors.of(context).primary),
                    ),
                    SizedBox(height: tokens.spacing.small),
                    Expanded(
                      child: Text(
                        'Michencio nacio en Bello el 18 de noviembre de 2020, se destaca por su curiocidad y por los daños que hace, cuando le caes mal te gruñe y si le caes bien te frota la cabeza',
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 7,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
