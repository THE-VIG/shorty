import 'package:drift/drift.dart';
import 'package:shorty/Data/database.dart';

final database = Database();

class DatabaseHelper {
  static Future<void> addCollection(String name) async =>
      await database.into(database.collection).insert(
            CollectionCompanion.insert(
              name: name,
            ),
          );

  static Future<void> addShortcut(
    String name,
    String url,
    int collection,
    String? color,
    String? imageUrl,
  ) async =>
      await database.into(database.shortcut).insert(
            ShortcutCompanion.insert(
              name: name,
              url: url,
              collection: collection,
              color: Value(color),
              imageUrl: Value(imageUrl),
            ),
          );
}
