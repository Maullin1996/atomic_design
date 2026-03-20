// Modelo
import 'package:atomic_design/design_system.dart';
import 'package:flutter/material.dart';

class DrawerItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  const DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isSelected = false,
  });
}

// Organismo
class AppDrawer extends StatelessWidget {
  final List<DrawerItem> items;
  final String? userName;
  final String? userEmail;
  final String? avatarUrl;
  final VoidCallback? onLogout;

  const AppDrawer({
    super.key,
    required this.items,
    this.userName,
    this.userEmail,
    this.avatarUrl,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            if (_hasHeader)
              _Header(
                userName: userName,
                userEmail: userEmail,
                avatarUrl: avatarUrl,
              ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: tokens.spacing.xSmall),
                children: items.map((item) => _DrawerItem(item: item)).toList(),
              ),
            ),
            if (onLogout != null) ...[
              Divider(
                indent: tokens.spacing.small,
                endIndent: tokens.spacing.small,
              ),
              _DrawerItem(
                item: DrawerItem(
                  icon: Icons.logout,
                  label: 'Cerrar sesión',
                  onTap: onLogout!,
                ),
                isDestructive: true,
              ),
              SizedBox(height: tokens.spacing.xSmall),
            ],
          ],
        ),
      ),
    );
  }

  bool get _hasHeader =>
      userName != null || userEmail != null || avatarUrl != null;
}

class _Header extends StatelessWidget {
  final String? userName;
  final String? userEmail;
  final String? avatarUrl;

  const _Header({this.userName, this.userEmail, this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(tokens.spacing.medium),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceLow,
        border: Border(
          bottom: BorderSide(color: AppColors.of(context).border, width: 1),
        ),
      ),
      child: Row(
        children: [
          _Avatar(avatarUrl: avatarUrl, userName: userName),
          SizedBox(width: tokens.spacing.small),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (userName != null) AppText.h6(userName!, maxLines: 1),
                if (userEmail != null)
                  AppText.label(
                    userEmail!,
                    color: AppColors.of(context).textSecondary,
                    maxLines: 1,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String? avatarUrl;
  final String? userName;

  const _Avatar({this.avatarUrl, this.userName});

  @override
  Widget build(BuildContext context) {
    final initials = _initials();

    if (avatarUrl != null) {
      return CircleAvatar(
        radius: 28,
        backgroundColor: AppColors.of(context).primary.withAlpha(26),
        child: ClipOval(
          child: AppNetworkImage(
            url: avatarUrl!,
            errorWidget: _InitialsOrIcon(initials: initials, context: context),
          ),
        ),
      );
    }

    return CircleAvatar(
      radius: 28,
      backgroundColor: AppColors.of(context).primary.withAlpha(26),
      child: _InitialsOrIcon(initials: initials, context: context),
    );
  }

  String? _initials() {
    if (userName == null) return null;
    final parts = userName!.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    if (parts[0].isNotEmpty) return parts[0][0].toUpperCase();
    return null;
  }
}

class _InitialsOrIcon extends StatelessWidget {
  final String? initials;
  final BuildContext context;

  const _InitialsOrIcon({this.initials, required this.context});

  @override
  Widget build(BuildContext context) {
    if (initials != null) {
      return Text(
        initials!,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(color: AppColors.of(context).primary),
      );
    }
    return Icon(Icons.person, color: AppColors.of(context).primary);
  }
}

class _DrawerItem extends StatelessWidget {
  final DrawerItem item;
  final bool isDestructive;

  const _DrawerItem({required this.item, this.isDestructive = false});

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final color = isDestructive
        ? AppColors.of(context).error
        : item.isSelected
        ? AppColors.of(context).primary
        : AppColors.of(context).textPrimary;

    return ListTile(
      selected: item.isSelected,
      selectedTileColor: AppColors.of(context).primary.withAlpha(26),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(tokens.radius.medium),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: tokens.spacing.small),
      leading: Icon(item.icon, color: color),
      title: Text(
        item.label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: color,
          fontWeight: item.isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      onTap: () {
        Scaffold.of(context).closeDrawer();
        item.onTap();
      },
    );
  }
}
