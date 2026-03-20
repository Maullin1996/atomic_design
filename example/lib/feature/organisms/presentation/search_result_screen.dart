import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Search Results'), leading: BackButton()),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(tokens.spacing.smallMedium),
            child: Container(
              padding: EdgeInsets.all(tokens.spacing.small),
              decoration: BoxDecoration(
                color: AppColors.of(context).surfaceLow,
                borderRadius: BorderRadius.circular(tokens.radius.medium),
              ),
              child: Column(
                children: [
                  AppSearchBar(
                    controller: controller,
                    onChanged: (value) {
                      setState(() {});
                      controller.text = value;
                    },
                  ),
                  AppResultSearchBar(
                    child: controller.value.text.isNotEmpty
                        ? ListView.separated(
                            itemCount: 50,
                            separatorBuilder:
                                (BuildContext context, int index) {
                                  return SizedBox(height: tokens.spacing.small);
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
                                        errorWidget: Icon(AppIcons.brokenImage),
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
          ),
        ),
      ),
    );
  }
}
