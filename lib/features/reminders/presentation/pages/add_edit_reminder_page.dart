import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../notifications/services/notification_service.dart';
import '../../domain/entities/reminder.dart';
import '../../domain/entities/recurrence_type.dart';
import '../providers/categories_provider.dart';
import '../providers/reminders_provider.dart';
import '../widgets/add_category_sheet.dart';

class AddEditReminderPage extends ConsumerStatefulWidget {
  const AddEditReminderPage({super.key, this.reminderId});

  final int? reminderId;

  @override
  ConsumerState<AddEditReminderPage> createState() =>
      _AddEditReminderPageState();
}

class _AddEditReminderPageState extends ConsumerState<AddEditReminderPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleCtrl;
  late final TextEditingController _descCtrl;
  late final TextEditingController _amountCtrl;

  String _category = 'payment';
  DateTime _dueDate = DateTime.now().add(const Duration(days: 7));
  String _currency = AppConstants.defaultCurrency;
  bool _isRecurring = false;
  RecurrenceType _recurrenceType = RecurrenceType.monthly;
  int _recurrenceInterval = 1;
  List<int> _notifyDaysBefore =
      List.from(AppConstants.defaultNotificationDays);

  bool _loading = false;
  Reminder? _existing;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController();
    _descCtrl = TextEditingController();
    _amountCtrl = TextEditingController();

    if (widget.reminderId != null) {
      _loadExisting();
    }
  }

  Future<void> _loadExisting() async {
    final reminder = await ref
        .read(remindersRepositoryProvider)
        .getById(widget.reminderId!);
    if (reminder == null || !mounted) return;
    setState(() {
      _existing = reminder;
      _titleCtrl.text = reminder.title;
      _descCtrl.text = reminder.description ?? '';
      _amountCtrl.text = reminder.amount?.toString() ?? '';
      _category = reminder.category;
      _dueDate = reminder.dueDate;
      _currency = reminder.currencyCode;
      _isRecurring = reminder.isRecurring;
      if (reminder.recurrenceType != null) {
        _recurrenceType = reminder.recurrenceType!;
      }
      _recurrenceInterval = reminder.recurrenceInterval ?? 1;
      _notifyDaysBefore =
          reminder.notificationSchedules.map((s) => s.daysBefore).toList();
    });
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    try {
      if (_notifyDaysBefore.isNotEmpty) {
        await NotificationService.requestPermission();
      }

      final reminder = Reminder(
        id: _existing?.id ?? 0,
        uuid: _existing?.uuid ?? '',
        title: _titleCtrl.text.trim(),
        description: _descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim(),
        category: _category,
        dueDate: _dueDate,
        amount: double.tryParse(_amountCtrl.text),
        currencyCode: _currency,
        isRecurring: _isRecurring,
        recurrenceType: _isRecurring ? _recurrenceType : null,
        recurrenceInterval: _isRecurring ? _recurrenceInterval : null,
        createdAt: _existing?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final savedId = await ref.read(saveReminderUseCaseProvider).call(reminder, _notifyDaysBefore);
      await NotificationService.scheduleForReminder(
        reminder.copyWith(id: savedId),
        _notifyDaysBefore,
      );

      if (mounted) context.pop();
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _delete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Reminder'),
        content: const Text('This reminder and all its notification schedules will be permanently deleted.'),
        actions: [
          TextButton(onPressed: () => ctx.pop(false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => ctx.pop(true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirm != true || !mounted) return;
    await ref.read(deleteReminderUseCaseProvider).call(_existing!.id);
    await NotificationService.cancelForReminder(_existing!.id);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.reminderId != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Reminder' : 'New Reminder'),
        actions: [
          if (isEdit)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              color: Colors.red,
              onPressed: _delete,
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleCtrl,
              decoration: const InputDecoration(labelText: 'Title *'),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Title is required' : null,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _descCtrl,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            const _SectionLabel('Category'),
            _CategorySelector(
              selected: _category,
              onChanged: (c) => setState(() => _category = c),
            ),
            const SizedBox(height: 16),
            const _SectionLabel('Due Date'),
            _DatePickerField(
              date: _dueDate,
              onChanged: (d) => setState(() => _dueDate = d),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _amountCtrl,
                    decoration: const InputDecoration(labelText: 'Amount'),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                const SizedBox(width: 12),
                _CurrencyDropdown(
                  value: _currency,
                  onChanged: (v) => setState(() => _currency = v!),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Recurring'),
              value: _isRecurring,
              onChanged: (v) => setState(() => _isRecurring = v),
              contentPadding: EdgeInsets.zero,
            ),
            if (_isRecurring) ...[
              Row(
                children: [
                  const Text('Every '),
                  SizedBox(
                    width: 60,
                    child: TextFormField(
                      initialValue: _recurrenceInterval.toString(),
                      keyboardType: TextInputType.number,
                      onChanged: (v) =>
                          _recurrenceInterval = int.tryParse(v) ?? 1,
                      decoration: const InputDecoration(isDense: true),
                    ),
                  ),
                  const SizedBox(width: 8),
                  DropdownButton<RecurrenceType>(
                    value: _recurrenceType,
                    onChanged: (v) =>
                        setState(() => _recurrenceType = v!),
                    items: RecurrenceType.values
                        .map((t) => DropdownMenuItem(
                              value: t,
                              child: Text(t.label.toLowerCase()),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 16),
            const _SectionLabel('Notify me before due date'),
            _NotifyDaysSelector(
              selected: _notifyDaysBefore,
              onChanged: (days) => setState(() => _notifyDaysBefore = days),
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: _loading ? null : _save,
              child: _loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(isEdit ? 'Save Changes' : 'Add Reminder'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              )),
    );
  }
}

class _CategorySelector extends ConsumerWidget {
  const _CategorySelector({required this.selected, required this.onChanged});
  final String selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final options = ref.watch(categoryOptionsProvider);

    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        ...options.map((opt) => ChoiceChip(
              label: Text(opt.label),
              selected: selected == opt.name,
              onSelected: (_) => onChanged(opt.name),
            )),
        // "+" chip to create a new category
        ActionChip(
          avatar: const Icon(Icons.add, size: 16),
          label: const Text('New'),
          onPressed: () => AddCategorySheet.show(context, ref),
        ),
      ],
    );
  }
}

class _DatePickerField extends StatelessWidget {
  const _DatePickerField({required this.date, required this.onChanged});
  final DateTime date;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: const Icon(Icons.calendar_today_outlined),
      label: Text(
        '${date.day.toString().padLeft(2, '0')} / '
        '${date.month.toString().padLeft(2, '0')} / '
        '${date.year}',
      ),
      onPressed: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) onChanged(picked);
      },
    );
  }
}

class _CurrencyDropdown extends StatelessWidget {
  const _CurrencyDropdown({required this.value, required this.onChanged});
  final String value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      onChanged: onChanged,
      items: AppConstants.supportedCurrencies
          .map((c) => DropdownMenuItem(value: c, child: Text(c)))
          .toList(),
    );
  }
}

class _NotifyDaysSelector extends StatelessWidget {
  const _NotifyDaysSelector(
      {required this.selected, required this.onChanged});
  final List<int> selected;
  final ValueChanged<List<int>> onChanged;

  static const _options = [1, 3, 7, 14, 30];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: _options.map((days) {
        final isSelected = selected.contains(days);
        return FilterChip(
          label: Text('$days day${days == 1 ? '' : 's'}'),
          selected: isSelected,
          onSelected: (v) {
            final updated = List<int>.from(selected);
            if (v) {
              updated.add(days);
            } else {
              updated.remove(days);
            }
            onChanged(updated);
          },
        );
      }).toList(),
    );
  }
}
