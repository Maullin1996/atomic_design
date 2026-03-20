import 'package:atomic_design_example/feature/atoms/domain/color_token.dart';
import 'package:flutter/material.dart';
import 'package:atomic_design/design_system.dart';

class ColorsScreen extends StatelessWidget {
  const ColorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ColorGroup> colorGroups = [
      ColorGroup('Brand Primary', [
        ColorToken(
          'primary',
          AppColors.of(context).primary,
          onColor: AppColors.of(context).onPrimary,
        ),
        ColorToken('primaryHover', AppColors.of(context).primaryHover),
        ColorToken('primaryPressed', AppColors.of(context).primaryPressed),
        ColorToken('primaryDisabled', AppColors.of(context).primaryDisabled),
        ColorToken('onPrimary', AppColors.of(context).onPrimary),
      ]),
      ColorGroup('Brand Secondary', [
        ColorToken(
          'secondary',
          AppColors.of(context).secondary,
          onColor: AppColors.of(context).onPrimary,
        ),
        ColorToken('secondaryHover', AppColors.of(context).secondaryHover),
        ColorToken('secondaryPressed', AppColors.of(context).secondaryPressed),
        ColorToken(
          'secondaryDisabled',
          AppColors.of(context).secondaryDisabled,
        ),
        ColorToken('onSecondary', AppColors.of(context).onSecondary),
      ]),
      ColorGroup('Surfaces', [
        ColorToken('background', AppColors.of(context).background),
        ColorToken('surfaceLow', AppColors.of(context).surfaceLow),
        ColorToken('surfaceMid', AppColors.of(context).surfaceMid),
        ColorToken('surfaceHigh', AppColors.of(context).surfaceHigh),
        ColorToken('onSurface', AppColors.of(context).onSurface),
        ColorToken('onSurfaceVariant', AppColors.of(context).onSurfaceVariant),
      ]),
      ColorGroup('Text', [
        ColorToken('textPrimary', AppColors.of(context).textPrimary),
        ColorToken('textSecondary', AppColors.of(context).textSecondary),
        ColorToken('textDisabled', AppColors.of(context).textDisabled),
        ColorToken('textInverse', AppColors.of(context).textInverse),
      ]),
      ColorGroup('Feedback', [
        ColorToken(
          'success',
          AppColors.of(context).success,
          onColor: AppColors.of(context).onSuccess,
        ),
        ColorToken(
          'warning',
          AppColors.of(context).warning,
          onColor: AppColors.of(context).onWarning,
        ),
        ColorToken(
          'error',
          AppColors.of(context).error,
          onColor: AppColors.of(context).onError,
        ),
        ColorToken(
          'info',
          AppColors.of(context).info,
          onColor: AppColors.of(context).onInfo,
        ),
      ]),
      ColorGroup('States', [
        ColorToken(
          'disabled',
          AppColors.of(context).disabled,
          onColor: AppColors.of(context).onDisabled,
        ),
        ColorToken('onDisabled', AppColors.of(context).onDisabled),
        ColorToken('focus', AppColors.of(context).focus),
        ColorToken('divider', AppColors.of(context).divider),
        ColorToken('border', AppColors.of(context).border),
      ]),
    ];
    return Scaffold(
      appBar: AppBar(title: Text('Colors'), leading: BackButton()),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: colorGroups.length,
        itemBuilder: (BuildContext context, int index) {
          return _ColorsGroupSection(group: colorGroups[index]);
        },
      ),
    );
  }
}

class _ColorsGroupSection extends StatelessWidget {
  final ColorGroup group;
  const _ColorsGroupSection({required this.group});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.of(context).border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(group.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.4,
            ),
            itemCount: group.tokens.length,
            itemBuilder: (BuildContext context, int index) {
              return _ColorTile(token: group.tokens[index]);
            },
          ),
        ],
      ),
    );
  }
}

class _ColorTile extends StatelessWidget {
  final ColorToken token;
  const _ColorTile({required this.token});

  @override
  Widget build(BuildContext context) {
    final hex =
        '#${token.color.toARGB32().toRadixString(16).substring(2).toUpperCase()}';
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceMid,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.of(context).border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            token.name,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.of(context).textPrimary,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.clip,
            ),
            maxLines: 1,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: token.color,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: token.onColor != null
                  ? Text(
                      'Aa',
                      style: TextStyle(
                        color: token.onColor,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            hex,
            style: TextStyle(
              fontSize: 11,
              color: AppColors.of(context).textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
