import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final colors = AppColors.of(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              tokens.spacing.small,
              tokens.spacing.smallMedium,
              tokens.spacing.small,
              tokens.spacing.xSmall,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: AppAssetsImage(
                        heightImage: 50,
                        widthImage: 50,
                        fit: BoxFit.cover,
                        path: 'assets/images/gerente.png',
                        errorWidget: Icon(AppIcons.brokenImage),
                      ),
                    ),
                    SizedBox(width: tokens.spacing.small),
                    AppText.h2('Titulo', color: colors.primary, softWrap: true),
                  ],
                ),
                SizedBox(height: tokens.spacing.smallMedium),
                AppCard(
                  color: colors.surfaceLow,
                  padding: EdgeInsetsGeometry.all(tokens.spacing.small),
                  child: AppSearchBar(
                    controller: controller,
                    onChanged: (value) {
                      setState(() {});
                      controller.text = value;
                    },
                  ),
                ),
                SizedBox(height: tokens.spacing.xSmall),
                Expanded(
                  child: Stack(
                    children: [
                      AppCardList(
                        emptyWidget: AppStateWidget(
                          title: 'Todavía no tiene Elementos',
                          type: AppStateType.empty,
                          image: 'assets/images/empty_icon.png',
                          onPressed: () {},
                          buttonChild: Text('Add Element'),
                        ),
                        type: CardListType.list,
                        errorWidget: AppStateWidget(
                          title: 'Todavía no tiene Elementos',
                          type: AppStateType.empty,
                          image: 'assets/images/empty_icon.png',
                          onPressed: () {},
                          buttonChild: Text('Add Element'),
                        ),
                        elementsList: _ElementsList(),
                      ),
                      AppResultSearchBar(
                        child: controller.value.text.isNotEmpty
                            ? ListView.separated(
                                itemCount: 50,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                      return SizedBox(
                                        height: tokens.spacing.small,
                                      );
                                    },
                                itemBuilder: (BuildContext context, int index) {
                                  return AppCard(
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                        tokens.spacing.xSmall,
                                      ),
                                      child: Row(
                                        children: [
                                          AppAssetsImage(
                                            path: 'assets/images/atoms.png',
                                            errorWidget: Icon(
                                              AppIcons.brokenImage,
                                            ),
                                            widthImage: 60,
                                          ),
                                          SizedBox(width: tokens.spacing.small),
                                          Expanded(
                                            child: Text(
                                              'Laboris veniam eiusmod Lorem consectetur ad exercitation cillum et ut est eiusmod laborum. ',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
