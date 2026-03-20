import 'package:atomic_design/design_system.dart';
import 'package:atomic_design_example/feature/atoms/domain/spacing_radios_token.dart';
import 'package:flutter/material.dart';

class SpacingRadiusScreen extends StatelessWidget {
  const SpacingRadiusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Spacing and radius'), leading: BackButton()),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(tokens.spacing.small),
          children: [
            _SpacingSection(),
            SizedBox(height: tokens.spacing.smallMedium),
            _RadiusSection(),
          ],
        ),
      ),
    );
  }
}

class _SpacingSection extends StatelessWidget {
  const _SpacingSection();

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final spacingTokens = [
      SpacingToken(label: 'xSmall · 5px', value: tokens.spacing.xSmall),
      SpacingToken(label: 'Small · 12px', value: tokens.spacing.small),
      SpacingToken(
        label: 'SmallMedium · 24px',
        value: tokens.spacing.smallMedium,
      ),
      SpacingToken(label: 'Medium · 34px', value: tokens.spacing.medium),
      SpacingToken(
        label: 'MediumLarge · 44px',
        value: tokens.spacing.mediumLarge,
      ),
      SpacingToken(label: 'Large · 64px', value: tokens.spacing.large),
      SpacingToken(
        label: 'ExtraLarge · 124px',
        value: tokens.spacing.extraLarge,
      ),
    ];
    return _TokenCard(
      title: 'Spacing Tokens',
      child: Column(
        children: spacingTokens.map((token) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    token.label,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                SizedBox(),
                Container(
                  height: token.value,
                  width: token.value,
                  decoration: BoxDecoration(
                    color: AppColors.of(context).primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _RadiusSection extends StatelessWidget {
  const _RadiusSection();

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final radiusTokens = [
      RadiusToken(label: 'Small · 8px', value: tokens.radius.small),
      RadiusToken(label: 'Medium · 12px', value: tokens.radius.medium),
      RadiusToken(label: 'Large · 16px', value: tokens.radius.large),
      RadiusToken(label: 'ExtraLarge · 24px', value: tokens.radius.extraLarge),
    ];
    return _TokenCard(
      title: 'Radius Tokens',
      child: Column(
        children: radiusTokens.map((token) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                SizedBox(
                  width: 140,
                  child: Text(
                    token.label,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),

                Container(
                  height: tokens.spacing.large,
                  width: tokens.spacing.large,
                  decoration: BoxDecoration(
                    color: AppColors.of(context).primary,
                    borderRadius: BorderRadius.circular(token.value),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _TokenCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _TokenCard({required this.title, required this.child});

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
          child,
        ],
      ),
    );
  }
}
