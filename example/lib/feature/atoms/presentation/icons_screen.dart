import 'package:atomic_design/design_system.dart';
import 'package:atomic_design_example/feature/atoms/domain/icon_token.dart';
import 'package:flutter/material.dart';

class IconsScreen extends StatelessWidget {
  const IconsScreen({super.key});

  static const _icons = [
    IconToken(name: 'User', icon: AppIcons.user),
    IconToken(name: 'Add Photo', icon: AppIcons.addPhoto),
    IconToken(name: 'Notification', icon: AppIcons.notification),
    IconToken(name: 'Add Tasks', icon: AppIcons.addTaks),
    IconToken(name: 'Link', icon: AppIcons.link),
    IconToken(name: 'Add Image', icon: AppIcons.addImage),
    IconToken(name: 'Add', icon: AppIcons.add),
    IconToken(name: 'Upload Drive', icon: AppIcons.uploadDrive),
    IconToken(name: 'Save File', icon: AppIcons.saveFile),
    IconToken(name: 'Back Icon', icon: AppIcons.backIcon),
    IconToken(name: 'Forward Icon', icon: AppIcons.forwardIcon),
    IconToken(name: 'Upload File', icon: AppIcons.uploadFile),
    IconToken(name: 'Dark Mode', icon: AppIcons.darkMode),
    IconToken(name: 'Light Mode', icon: AppIcons.lightMode),
    IconToken(name: 'Broken Image', icon: AppIcons.brokenImage),
    IconToken(name: 'Calendar', icon: AppIcons.calendart),
    IconToken(name: 'Take Photo', icon: AppIcons.takePhoto),
    IconToken(name: 'Camera', icon: AppIcons.camera),
    IconToken(name: 'Success', icon: AppIcons.succes),
    IconToken(name: 'Check', icon: AppIcons.check),
    IconToken(name: 'Uncheck', icon: AppIcons.unCheck),
    IconToken(name: 'Close', icon: AppIcons.close),
    IconToken(name: 'Copy', icon: AppIcons.copy),
    IconToken(name: 'Delete', icon: AppIcons.delete),
    IconToken(name: 'Error', icon: AppIcons.error),
    IconToken(name: 'Favorite', icon: AppIcons.favorite),
    IconToken(name: 'Unfavorite', icon: AppIcons.unFavorite),
    IconToken(name: 'Information', icon: AppIcons.information),
    IconToken(name: 'Edit', icon: AppIcons.edit),
    IconToken(name: 'Menu', icon: AppIcons.menu),
    IconToken(name: 'Image', icon: AppIcons.image),
    IconToken(name: 'Minimise', icon: AppIcons.minimise),
    IconToken(name: 'Obscure Password', icon: AppIcons.obscurePassword),
    IconToken(name: 'Show Password', icon: AppIcons.showPassword),
    IconToken(name: 'Warning', icon: AppIcons.warning),
    IconToken(name: 'Save', icon: AppIcons.save),
  ];

  int _columnCount(double width) {
    if (width < 360) return 2;
    if (width < 414) return 3;
    if (width < 600) return 3;
    if (width < 840) return 4;
    return 6;
  }

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(title: const Text('Icons'), leading: const BackButton()),
      body: SafeArea(
        child: GridView.builder(
          padding: EdgeInsets.all(tokens.spacing.small),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _columnCount(width),
            crossAxisSpacing: tokens.spacing.xSmall,
            mainAxisSpacing: tokens.spacing.xSmall,
            childAspectRatio: 0.85,
          ),
          itemCount: _icons.length,
          itemBuilder: (context, index) => _IconCard(token: _icons[index]),
        ),
      ),
    );
  }
}

class _IconCard extends StatelessWidget {
  final IconToken token;
  const _IconCard({required this.token});

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final colors = AppColors.of(context);

    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(tokens.spacing.xSmall),
      decoration: BoxDecoration(
        color: colors.surfaceLow,
        borderRadius: BorderRadius.circular(tokens.radius.medium),
        border: Border.all(color: colors.border),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(token.icon, size: 32, color: colors.textPrimary),
            SizedBox(height: tokens.spacing.xSmall),
            Text(
              token.name,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
