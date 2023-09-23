import 'package:drift/drift.dart';
import 'package:shorty/database/database.dart';
import 'package:shorty/helper.dart';
import 'package:shorty/models/models.dart' as models;

final _database = Database();

class DatabaseHelper extends Helper {
  models.Collection _collectionDataToModel(CollectionData data) =>
      models.Collection(
        id: data.id,
        name: data.name,
      );

  models.Shortcut _shortcutDataToModel(ShortcutData data) => models.Shortcut(
        id: data.id,
        name: data.name,
        collection: data.collection,
        url: data.url,
        color: data.color,
        imageUrl: data.imageUrl,
      );

  @override
  Future<void> addCollection(String name) async {
    await _database.into(_database.collection).insert(
          CollectionCompanion.insert(name: name),
        );
  }

  @override
  Future<void> addShortcut(String name, String url, int collection,
      String? color, String? imageUrl) async {
    await _database.into(_database.shortcut).insert(
          ShortcutCompanion.insert(
            name: name,
            collection: collection,
            url: url,
            color: Value(color),
            imageUrl: Value(imageUrl),
          ),
        );
  }

  @override
  Future<void> deleteCollection(int id) async {
    await (_database.delete(_database.collection)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  @override
  Future<void> deleteShortcut(int id) async {
    await (_database.delete(_database.shortcut)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  @override
  Future<models.Collection> getCollection(int id) async {
    final data = await (_database.collection.select()
          ..where((tbl) => tbl.id.equals(id)))
        .getSingle();

    return _collectionDataToModel(data);
  }

  @override
  Future<List<models.Collection>> getCollections() async {
    final data = await _database.collection.select().get();
    final collections = <models.Collection>[];

    for (var d in data) {
      collections.add(_collectionDataToModel(d));
    }

    return collections;
  }

  @override
  Future<models.Shortcut> getShortcut(int id) async {
    final data = await (_database.select(_database.shortcut)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingle();

    return _shortcutDataToModel(data);
  }

  @override
  Future<List<models.Shortcut>> getShortcuts(int collectionId) async {
    final statement = _database.select(_database.shortcut)
      ..where((tbl) => tbl.collection.equals(collectionId));
    final data = await statement.get();

    final shortcuts = <models.Shortcut>[];
    for (var shortcut in data) {
      shortcuts.add(_shortcutDataToModel(shortcut));
    }

    return shortcuts;
  }

  @override
  Stream<List<models.Shortcut>> watchShortcuts(int collectionId) {
    final statement = _database.select(_database.shortcut)
      ..where((tbl) => tbl.collection.equals(collectionId));

    final shotrcutsStream = statement
        .map<models.Shortcut>((data) => _shortcutDataToModel(data))
        .watch();

    return shotrcutsStream;
  }

  @override
  Stream<List<models.Collection>> watchCollections() {
    final statement = _database.select(_database.collection);

    final stream = statement
        .map<models.Collection>((data) => _collectionDataToModel(data))
        .watch();

    return stream;
  }

  @override
  Future<void> updateCollection(int id, String name) async {
    await _database.update(_database.collection).replace(
          CollectionCompanion.insert(
            id: Value(id),
            name: name,
          ),
        );
  }

  @override
  Future<void> updateShortcut(int id, String name, String url, int collection,
      String? color, String? imageUrl) async {
    await _database.update(_database.shortcut).replace(
          ShortcutCompanion.insert(
            id: Value(id),
            name: name,
            url: url,
            collection: collection,
            color: Value(color),
            imageUrl: Value(imageUrl),
          ),
        );
  }
}
