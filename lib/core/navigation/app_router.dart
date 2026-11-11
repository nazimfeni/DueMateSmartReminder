import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/reminders/presentation/pages/reminders_list_page.dart';
import '../../features/reminders/presentation/pages/add_edit_reminder_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/settings/presentation/pages/privacy_policy_page.dart';
import '../../features/backup/presentation/pages/backup_page.dart';

abstract final class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/reminders',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => _AppShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/reminders',
                builder: (context, state) => const RemindersListPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/reminders/add',
        builder: (context, state) => const AddEditReminderPage(),
      ),
      GoRoute(
        path: '/reminders/:id/edit',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return AddEditReminderPage(reminderId: id);
        },
      ),
      GoRoute(
        path: '/backup',
        builder: (context, state) => const BackupPage(),
      ),
      GoRoute(
        path: '/privacy-policy',
        builder: (context, state) => const PrivacyPolicyPage(),
      ),
    ],
  );
}

class _AppShell extends StatelessWidget {
  const _AppShell({required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: shell.goBranch,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications),
            label: 'Reminders',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: shell.currentIndex == 0
          ? FloatingActionButton(
              onPressed: () => context.push('/reminders/add'),
              child: const Icon(Icons.add),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
