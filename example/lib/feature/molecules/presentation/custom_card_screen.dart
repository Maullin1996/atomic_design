import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

class CustomCardScreen extends StatefulWidget {
  const CustomCardScreen({super.key});

  @override
  State<CustomCardScreen> createState() => _CustomCardScreenState();
}

class _CustomCardScreenState extends State<CustomCardScreen> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Custom Card'), leading: BackButton()),
      body: ListView(
        padding: EdgeInsets.all(tokens.spacing.small),
        children: [
          _ContentCard(),
          SizedBox(height: tokens.spacing.smallMedium),
          _LoadingCard(isLoading: isLoading, child: _ContentCard()),
          SizedBox(height: tokens.spacing.smallMedium),
          AppButtons(
            type: ButtonType.primaryTextButton,
            title: Text(
              'Toggle',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            fontSize: tokens.typography.h4,
            onPressed: () => setState(() => isLoading = !isLoading),
          ),
        ],
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  const _LoadingCard({required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 250),
      child: AppCard(
        isLoading: isLoading,
        padding: EdgeInsets.all(16),
        child: isLoading ? SizedBox.shrink() : child,
      ),
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
                    'https://m.media-amazon.com/images/I/41QZSg8drOL._AC_UF894,1000_QL80_.jpg',
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
