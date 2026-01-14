import 'package:flutter/material.dart';
import 'package:tribe/features/matchmaking/domain/entities/tags.dart';

class MyTagPicker extends StatelessWidget {
  final TagCategory category;
  final List<Tag> selectedTags;
  final ValueChanged<Tag> onTagAdded;
  final ValueChanged<Tag> onTagRemoved;

  const MyTagPicker({
    super.key,
    required this.category,
    required this.selectedTags,
    required this.onTagAdded,
    required this.onTagRemoved,
  });

  @override
  Widget build(BuildContext context) {
    final availableTags = category.tags
        .where((t) => !selectedTags.any((s) => s.id == t.id))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...selectedTags.map(
              (tag) => InputChip(
                label: Text(tag.label),
                onDeleted: () => onTagRemoved(tag),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: availableTags.isEmpty
                  ? null
                  : () => _showTagPicker(
                        context,
                        availableTags,
                      ),
            ),
          ],
        ),
      ],
    );
  }

  void _showTagPicker(BuildContext context, List<Tag> tags) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ListView(
          children: tags.map((tag) {
            return ListTile(
              title: Text(tag.label),
              onTap: () {
                Navigator.pop(context);
                onTagAdded(tag);
              },
            );
          }).toList(),
        );
      },
    );
  }
}
