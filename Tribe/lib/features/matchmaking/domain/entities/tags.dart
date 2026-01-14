class Tag {
  final String id;
  final String label;

  Tag({required this.id, required this.label});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
    };
  }
}

class TagCategory {
  final String id;
  final String name;
  final List<Tag> tags;

  TagCategory({
    required this.id,
    required this.name,
    required this.tags,
  });
}
