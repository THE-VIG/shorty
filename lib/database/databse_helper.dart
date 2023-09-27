import 'package:drift/drift.dart';
import 'package:shorty/database/database.dart' hide Collection, Shortcut;
import 'package:shorty/helper.dart';
import 'package:shorty/models/models.dart';

final _database = Database();

class DatabaseHelper extends Helper {
  Collection _collectionDataToModel(CollectionData data) => Collection(
        id: data.id,
        name: data.name,
        type: data.type == 0 ? CollectionType.web : CollectionType.app,
      );

  Shortcut _shortcutDataToModel(ShortcutData data) => Shortcut(
        id: data.id,
        name: data.name,
        collection: data.collection,
        url: data.url,
        color: data.color,
        imageUrl: data.imageUrl,
      );

  @override
  Future<void> addCollection(String name, CollectionType type) async {
    await _database.into(_database.collection).insert(
          CollectionCompanion.insert(
            name: name,
            type: Value(type.index),
          ),
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
  Future<Collection> getCollection(int id) async {
    final data = await (_database.collection.select()
          ..where((tbl) => tbl.id.equals(id)))
        .getSingle();

    return _collectionDataToModel(data);
  }

  @override
  Future<List<Collection>> getCollections(CollectionType type) async {
    final data = await (_database.collection.select()
          ..where((tbl) => tbl.type.equals(type.index)))
        .get();
    final collections = <Collection>[];

    for (var d in data) {
      collections.add(_collectionDataToModel(d));
    }

    return collections;
  }

  @override
  Future<Shortcut> getShortcut(int id) async {
    final data = await (_database.select(_database.shortcut)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingle();

    return _shortcutDataToModel(data);
  }

  @override
  Future<List<Shortcut>> getShortcuts(int collectionId) async {
    final statement = _database.select(_database.shortcut)
      ..where((tbl) => tbl.collection.equals(collectionId));
    final data = await statement.get();

    final shortcuts = <Shortcut>[];
    for (var shortcut in data) {
      shortcuts.add(_shortcutDataToModel(shortcut));
    }

    return shortcuts;
  }

  @override
  Stream<List<Shortcut>> watchShortcuts(int collectionId) {
    final statement = _database.select(_database.shortcut)
      ..where((tbl) => tbl.collection.equals(collectionId));

    final shotrcutsStream =
        statement.map<Shortcut>((data) => _shortcutDataToModel(data)).watch();

    return shotrcutsStream;
  }

  @override
  Stream<List<Collection>> watchCollections(CollectionType type) {
    final statement = _database.select(_database.collection)
      ..where((tbl) => tbl.type.equals(type.index));

    final stream = statement
        .map<Collection>((data) => _collectionDataToModel(data))
        .watch();

    return stream;
  }

  @override
  Future<void> updateCollection(
    int id,
    String name,
    CollectionType type,
  ) async {
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
