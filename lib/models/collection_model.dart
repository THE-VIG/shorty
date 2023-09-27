class Collection {
  final int id;
  final String name;
  final CollectionType type;

  Collection({
    required this.id,
    required this.name,
    required this.type,
  });
}

enum CollectionType { web, app }
