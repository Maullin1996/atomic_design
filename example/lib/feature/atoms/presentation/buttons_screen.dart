import 'package:flutter/material.dart';
import 'package:atomic_design/design_system.dart';
import 'package:atomic_design_example/feature/atoms/domain/button_token.dart';

class ButtonsScreen extends StatelessWidget {
  const ButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const buttonToken = [
      ButtonToken(
        title: 'Primary · Filled',
        type: ButtonType.primaryFillButton,
      ),
      ButtonToken(
        title: 'Primary · Icon Filled',
        type: ButtonType.primaryIconFillButton,
        hasIcon: true,
      ),
      ButtonToken(title: 'Primary · Text', type: ButtonType.primaryTextButton),
    ];

    const iconButtonTokens = [
      ButtonToken(
        title: 'Primary · Icon',
        type: ButtonType.primaryIconButton,
        hasIcon: true,
      ),
      ButtonToken(
        title: 'Primary · Floating rectangular',
        type: ButtonType.primaryFloatingButton,
        hasIcon: true,
      ),
      ButtonToken(
        title: 'Primary · Floating circular',
        type: ButtonType.primaryFloatingButton,
        hasIcon: true,
        shape: CircleBorder(),
      ),
      ButtonToken(
        title: 'Primary · Image  Button',
        type: ButtonType.primaryImageButton,
      ),
    ];
    return Scaffold(
      appBar: AppBar(title: Text('Buttons'), leading: BackButton()),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _ButtonsSection(
              title: 'Text & Filled Buttons',
              tokens: buttonToken,
            ),
            const SizedBox(height: 24),
            _ButtonsSection(title: 'Icon Buttons', tokens: iconButtonTokens),
          ],
        ),
      ),
    );
  }
}

class _ButtonsSection extends StatelessWidget {
  final String title;
  final List<ButtonToken> tokens;
  const _ButtonsSection({required this.title, required this.tokens});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.of(context).border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          ...tokens.map((token) => _ButtonPreview(token: token)),
        ],
      ),
    );
  }
}

class _ButtonPreview extends StatelessWidget {
  final ButtonToken token;

  const _ButtonPreview({required this.token});

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(token.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Row(
            children: [
              AppButtons(
                title: Text(
                  'Enabled',
                  style: TextStyle(
                    fontFamily: tokens.typography.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                type: token.type,
                icon: token.hasIcon ? AppIcons.camera : null,
                iconForFilledButton: token.hasIcon
                    ? Icon(Icons.facebook)
                    : null,
                iconSize: token.hasIcon ? 34 : null,
                onPressed: () {},
                shape: token.shape,
              ),
              const SizedBox(width: 12),
              AppButtons(
                title: Text(
                  'Disabled',
                  style: TextStyle(
                    fontFamily: tokens.typography.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                type: token.type,
                icon: token.hasIcon ? AppIcons.camera : null,
                iconForFilledButton: token.hasIcon
                    ? Icon(Icons.facebook)
                    : null,
                iconSize: token.hasIcon ? 34 : null,
                onPressed: null,
                shape: token.shape,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
