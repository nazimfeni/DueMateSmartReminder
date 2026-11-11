import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../notifications/services/notification_service.dart';
import '../../domain/entities/reminder.dart';
import '../providers/categories_provider.dart';
import '../providers/reminders_provider.dart';
import '../widgets/add_category_sheet.dart';

class RemindersListPage extends ConsumerWidget {
  const RemindersListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remindersAsync = ref.watch(filteredRemindersProvider);
    final filter = ref.watch(categoryFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DueMate'),
        actions: [
          IconButton(
            icon: const Icon(Icons.backup_outlined),
            tooltip: 'Backup',
            onPressed: () => context.push('/backup'),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: _CategoryFilterBar(selected: filter),
        ),
      ),
      body: remindersAsync.when(
        data: (reminders) => reminders.isEmpty
            ? const _EmptyState()
            : _RemindersList(reminders: reminders),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _CategoryFilterBar extends ConsumerWidget {
  const _CategoryFilterBar({required this.selected});

  final String? selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final options = ref.watch(categoryOptionsProvider);

    return SizedBox(
      height: 52,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        children: [
          _FilterChip(
            label: 'All',
            selected: selected == null,
            onTap: () =>
                ref.read(categoryFilterProvider.notifier).state = null,
          ),
          ...options.map((opt) => _FilterChip(
                label: opt.label,
                selected: selected == opt.name,
                color: opt.color,
                onTap: () =>
                    ref.read(categoryFilterProvider.notifier).state = opt.name,
              )),
          // "+" chip to add a new custom category
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ActionChip(
              avatar: const Icon(Icons.add, size: 16),
              label: const Text('New'),
              onPressed: () => AddCategorySheet.show(context, ref),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.color,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        selectedColor: (color ?? scheme.primary).withValues(alpha: 0.2),
        checkmarkColor: color ?? scheme.primary,
        labelStyle: TextStyle(
          color: selected ? (color ?? scheme.primary) : null,
          fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}

class _RemindersList extends ConsumerWidget {
  const _RemindersList({required this.reminders});

  final List<Reminder> reminders;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: reminders.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        return _ReminderCard(reminder: reminders[index]);
      },
    );
  }
}

class _ReminderCard extends ConsumerWidget {
  const _ReminderCard({required this.reminder});

  final Reminder reminder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final statusColor = _statusColor();

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.push('/reminders/${reminder.id}/edit'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 56,
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            reminder.title,
                            style: textTheme.titleSmall?.copyWith(
                              decoration: reminder.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        _CategoryBadge(category: reminder.category),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _dueDateLabel(),
                      style: textTheme.bodySmall?.copyWith(color: statusColor),
                    ),
                    if (reminder.amount != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        '${reminder.currencyCode} ${reminder.amount!.toStringAsFixed(2)}',
                        style: textTheme.bodySmall
                            ?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Checkbox(
                value: reminder.isCompleted,
                onChanged: reminder.isCompleted
                    ? null
                    : (v) async {
                        if (v == true) {
                          await ref.read(markCompleteUseCaseProvider).call(reminder.id);
                          await NotificationService.cancelForReminder(reminder.id);
                        }
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _statusColor() {
    if (reminder.isCompleted) return AppColors.completed;
    if (reminder.isOverdue) return AppColors.overdue;
    if (reminder.isDueToday) return AppColors.dueToday;
    return AppColors.upcoming;
  }

  String _dueDateLabel() {
    if (reminder.isCompleted) return 'Completed';
    if (reminder.isOverdue) {
      final days = reminder.dueDate.difference(DateTime.now()).inDays.abs();
      return 'Overdue by $days day${days == 1 ? '' : 's'}';
    }
    if (reminder.isDueToday) return 'Due today';
    final days = reminder.daysUntilDue;
    return 'Due in $days day${days == 1 ? '' : 's'}';
  }
}

class _CategoryBadge extends ConsumerWidget {
  const _CategoryBadge({required this.category});

  final String category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final options = ref.watch(categoryOptionsProvider);
    final color = _resolveColor(options);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _resolveLabel(options),
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _resolveColor(List<CategoryOption> options) {
    final match = options.where((o) => o.name == category).firstOrNull;
    return match?.color ?? AppColors.payment;
  }

  String _resolveLabel(List<CategoryOption> options) {
    final match = options.where((o) => o.name == category).firstOrNull;
    return match?.label ?? category;
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none_outlined,
              size: 72, color: scheme.outlineVariant),
          const SizedBox(height: 16),
          Text('No reminders yet',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            'Tap + to add your first reminder',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: scheme.outline),
          ),
        ],
      ),
    );
  }
}
