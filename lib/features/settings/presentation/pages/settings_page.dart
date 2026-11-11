import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../notifications/services/notification_service.dart';
import '../../../settings/data/repositories/settings_repository.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(appLocaleProvider);
    final currency = ref.watch(defaultCurrencyProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          const _SectionHeader('Appearance'),
          ListTile(
            leading: const Icon(Icons.brightness_6_outlined),
            title: const Text('Theme'),
            trailing: DropdownButton<ThemeMode>(
              value: themeMode,
              underline: const SizedBox(),
              onChanged: (v) =>
                  ref.read(themeModeProvider.notifier).set(v!),
              items: const [
                DropdownMenuItem(
                    value: ThemeMode.system, child: Text('System')),
                DropdownMenuItem(
                    value: ThemeMode.light, child: Text('Light')),
                DropdownMenuItem(
                    value: ThemeMode.dark, child: Text('Dark')),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.language_outlined),
            title: const Text('Language'),
            trailing: DropdownButton<Locale?>(
              value: locale,
              underline: const SizedBox(),
              onChanged: (v) =>
                  ref.read(appLocaleProvider.notifier).set(v),
              items: const [
                DropdownMenuItem(value: null, child: Text('System')),
                DropdownMenuItem(
                    value: Locale('en'), child: Text('English')),
                DropdownMenuItem(
                    value: Locale('bn'), child: Text('বাংলা')),
              ],
            ),
          ),
          const Divider(),
          const _SectionHeader('Defaults'),
          ListTile(
            leading: const Icon(Icons.currency_exchange_outlined),
            title: const Text('Default Currency'),
            trailing: DropdownButton<String>(
              value: currency,
              underline: const SizedBox(),
              onChanged: (v) =>
                  ref.read(defaultCurrencyProvider.notifier).set(v!),
              items: AppConstants.supportedCurrencies
                  .map((c) =>
                      DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
            ),
          ),
          const Divider(),
          const _SectionHeader('Notifications'),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text('Allow Notifications'),
            subtitle: const Text('Required for reminder alerts'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              final granted = await NotificationService.requestPermission();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(granted
                      ? 'Notifications enabled'
                      : 'Permission denied — enable in device settings'),
                ));
              }
            },
          ),
          const Divider(),
          const _SectionHeader('Data'),
          ListTile(
            leading: const Icon(Icons.backup_outlined),
            title: const Text('Backup & Restore'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/backup'),
          ),
          const Divider(),
          const _SectionHeader('About'),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('App Name'),
            trailing: Text('DueMate – Smart Reminder'),
          ),
          const ListTile(
            leading: Icon(Icons.tag_outlined),
            title: Text('Version'),
            trailing: Text('1.0.0'),
          ),
          ListTile(
            leading: const Icon(Icons.policy_outlined),
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/privacy-policy'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              letterSpacing: 1.2,
            ),
      ),
    );
  }
}
