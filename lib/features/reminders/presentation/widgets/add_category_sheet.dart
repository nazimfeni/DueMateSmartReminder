import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/app_providers.dart';

class AddCategorySheet extends ConsumerStatefulWidget {
  const AddCategorySheet({super.key});

  /// Convenience method to show the sheet.
  static Future<void> show(BuildContext context, WidgetRef ref) {
    final container = ProviderScope.containerOf(context);
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => UncontrolledProviderScope(
        container: container,
        child: const AddCategorySheet(),
      ),
    );
  }

  @override
  ConsumerState<AddCategorySheet> createState() => _AddCategorySheetState();
}

class _AddCategorySheetState extends ConsumerState<AddCategorySheet> {
  static const _swatchColors = <Color>[
    Color(0xFFE53935), // red
    Color(0xFFF4511E), // orange
    Color(0xFFFFB300), // amber
    Color(0xFF43A047), // green
    Color(0xFF00897B), // teal
    Color(0xFF1E88E5), // blue
    Color(0xFF8E24AA), // purple
    Color(0xFF6D4C41), // brown
  ];

  final _nameCtrl = TextEditingController();
  Color _selectedColor = _swatchColors.first;
  bool _saving = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _add() async {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) return;

    setState(() => _saving = true);
    try {
      await ref
          .read(customCategoriesDaoProvider)
          .insert(name, _selectedColor.toARGB32());
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        final isDuplicate =
            e.toString().toLowerCase().contains('unique');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isDuplicate
                  ? 'A category named "$name" already exists.'
                  : 'Failed to add category: $e',
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('New Category',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          TextField(
            controller: _nameCtrl,
            decoration: const InputDecoration(
              labelText: 'Category name',
              border: OutlineInputBorder(),
            ),
            textCapitalization: TextCapitalization.sentences,
            autofocus: true,
            onSubmitted: (_) => _add(),
          ),
          const SizedBox(height: 16),
          Text('Pick a colour',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: scheme.primary,
                  )),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _swatchColors.map((color) {
              final isSelected = color == _selectedColor;
              return GestureDetector(
                onTap: () => setState(() => _selectedColor = color),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: isSelected
                        ? Border.all(
                            color: scheme.onSurface,
                            width: 3,
                          )
                        : null,
                  ),
                  child: isSelected
                      ? Icon(Icons.check,
                          size: 18, color: scheme.surface)
                      : null,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _saving ? null : _add,
              child: _saving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Add'),
            ),
          ),
        ],
      ),
    );
  }
}
