import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: AppTheme.borderColor,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Your Name',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    '@yourhandle',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text(
                        '128',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        ' Following',
                        style: TextStyle(color: AppTheme.textSecondary),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        '1.2K',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        ' Followers',
                        style: TextStyle(color: AppTheme.textSecondary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: AppTheme.borderColor),
            _DrawerItem(
              icon: Icons.person_outline,
              label: 'Profile',
              onTap: () {},
            ),
            _DrawerItem(
              icon: Icons.verified_outlined,
              label: 'Premium',
              onTap: () {},
            ),
            _DrawerItem(
              icon: Icons.bookmark_border,
              label: 'Bookmarks',
              onTap: () {},
            ),
            _DrawerItem(
              icon: Icons.list_alt,
              label: 'Lists',
              onTap: () {},
            ),
            _DrawerItem(
              icon: Icons.group_outlined,
              label: 'Communities',
              onTap: () {},
            ),
            _DrawerItem(
              icon: Icons.monetization_on_outlined,
              label: 'Monetization',
              onTap: () {},
            ),
            const Divider(color: AppTheme.borderColor),
            _DrawerItem(
              icon: Icons.settings_outlined,
              label: 'Settings and Support',
              onTap: () {},
              hasDropdown: true,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.lightbulb_outline,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.qr_code_scanner,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool hasDropdown;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.hasDropdown = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
        size: 26,
      ),
      title: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: hasDropdown
          ? const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            )
          : null,
      onTap: onTap,
    );
  }
}
