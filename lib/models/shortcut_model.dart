import 'package:equatable/equatable.dart';

class Shortcut extends Equatable {
  final int id;
  final String name;
  final String url;
  final int collection;
  final String? color;
  final String? imageUrl;

  const Shortcut({
    required this.id,
    required this.name,
    required this.url,
    required this.collection,
    this.color,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        url,
        collection,
        color,
        imageUrl,
      ];
}
