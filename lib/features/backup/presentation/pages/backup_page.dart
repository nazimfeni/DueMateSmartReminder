import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../reminders/presentation/providers/reminders_provider.dart';
import '../../services/backup_service.dart';

final _backupServiceProvider = Provider<BackupService>((ref) {
  return BackupService(ref.watch(remindersRepositoryProvider));
});

class BackupPage extends ConsumerWidget {
  const BackupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Backup & Restore')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionCard(
            icon: Icons.upload_outlined,
            title: 'Export',
            subtitle: 'Save your data to a file on this device.',
            children: [
              _ActionTile(
                icon: Icons.code,
                label: 'Export as JSON',
                subtitle: 'Full backup — can be imported back',
                onTap: () async {
                  final ok =
                      await ref.read(_backupServiceProvider).exportJson();
                  if (context.mounted) {
                    _showSnack(
                        context, ok ? 'Export successful' : 'Export failed');
                  }
                },
              ),
              _ActionTile(
                icon: Icons.table_chart_outlined,
                label: 'Export as CSV',
                subtitle: 'Open in spreadsheet apps',
                onTap: () async {
                  final ok =
                      await ref.read(_backupServiceProvider).exportCsv();
                  if (context.mounted) {
                    _showSnack(
                        context, ok ? 'CSV exported' : 'Export failed');
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SectionCard(
            icon: Icons.download_outlined,
            title: 'Import',
            subtitle: 'Restore from a previously exported JSON backup.',
            children: [
              _ActionTile(
                icon: Icons.merge_outlined,
                label: 'Import & Merge',
                subtitle: 'Add imported reminders to existing ones',
                onTap: () => _import(context, ref, merge: true),
              ),
              _ActionTile(
                icon: Icons.replay_outlined,
                label: 'Import & Replace',
                subtitle: 'Replaces all current reminders',
                isDestructive: true,
                onTap: () => _import(context, ref, merge: false),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SectionCard(
            icon: Icons.delete_forever_outlined,
            title: 'Danger Zone',
            subtitle: 'Irreversible actions.',
            children: [
              _ActionTile(
                icon: Icons.delete_outline,
                label: 'Delete All Data',
                subtitle: 'Removes all reminders permanently',
                isDestructive: true,
                onTap: () => _deleteAll(context, ref),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _import(
      BuildContext context, WidgetRef ref, {required bool merge}) async {
    if (!merge) {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Replace All Data?'),
          content: const Text(
              'This will permanently delete all existing reminders and replace them with the imported data.'),
          actions: [
            TextButton(
                onPressed: () => ctx.pop(false),
                child: const Text('Cancel')),
            TextButton(
                onPressed: () => ctx.pop(true),
                child: const Text('Replace',
                    style: TextStyle(color: Colors.red))),
          ],
        ),
      );
      if (confirm != true || !context.mounted) return;
    }

    final result =
        await ref.read(_backupServiceProvider).importJson(merge: merge);
    if (!context.mounted) return;

    if (result.cancelled) return;
    if (result.success) {
      _showSnack(context, 'Imported ${result.count} reminders');
    } else {
      _showSnack(context, result.error ?? 'Import failed');
    }
  }

  Future<void> _deleteAll(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete All Data?'),
        content: const Text(
            'All reminders and notification schedules will be permanently deleted. This cannot be undone.'),
        actions: [
          TextButton(
              onPressed: () => ctx.pop(false), child: const Text('Cancel')),
          TextButton(
              onPressed: () => ctx.pop(true),
              child: const Text('Delete All',
                  style: TextStyle(color: Colors.red))),
        ],
      ),
    );
    if (confirm != true || !context.mounted) return;

    await ref.read(remindersRepositoryProvider).deleteAll();
    if (context.mounted) _showSnack(context, 'All data deleted');
  }

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.children,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(title,
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 4),
            Text(subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    )),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive
        ? Theme.of(context).colorScheme.error
        : Theme.of(context).colorScheme.onSurface;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: color),
      title: Text(label, style: TextStyle(color: color)),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }
}
