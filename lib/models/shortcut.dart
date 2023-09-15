class Shortcut {
  final String name;
  final String url;
  final int collection;
  final String? color;
  final String? imageUrl;

  Shortcut({
    required this.name,
    required this.url,
    required this.collection,
    this.color,
    this.imageUrl,
  });
}
