import 'package:drift/drift.dart';
import 'package:shorty/database/database.dart';
import 'package:shorty/helper.dart';
import 'package:shorty/models/models.dart' as models;

final _database = Database();

class DatabaseHelper extends Helper {
  @override
  Future<void> addCollection(String name) async {
    await _database.into(_database.collection).insert(
          CollectionCompanion.insert(
            name: name,
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
  Future<models.Collection> getCollection(int id) {
    // TODO: implement getCollection
    throw UnimplementedError();
  }

  @override
  Future<List<models.Collection>> getCollections() async {
    final response = await _database.collection.select().get();
    final collections = <models.Collection>[];

    for (var collection in response) {
      collections.add(
        models.Collection(
          id: collection.id,
          name: collection.name,
        ),
      );
    }

    return collections;
  }

  @override
  Future<models.Shortcut> getShortcut(int id) {
    // TODO: implement getShortcut
    throw UnimplementedError();
  }

  @override
  Future<List<models.Shortcut>> getShortcuts(int collectionId) async {
    final statement = _database.select(_database.shortcut)
      ..where((tbl) => tbl.collection.equals(collectionId));
    final shortcutsData = await statement.get();
    final shortcuts = <models.Shortcut>[];

    for (var shortcut in shortcutsData) {
      shortcuts.add(
        models.Shortcut(
          id: shortcut.id,
          name: shortcut.name,
          collection: shortcut.collection,
          url: shortcut.url,
          color: shortcut.color,
          imageUrl: shortcut.imageUrl,
        ),
      );
    }

    return shortcuts;
  }

  @override
  Stream<List<models.Shortcut>> watchShortcuts(int collectionId) {
    final statement = _database.select(_database.shortcut)
      ..where((tbl) => tbl.collection.equals(collectionId));

    final shotrcutsStream = statement
        .map<models.Shortcut>(
          (shortcutData) => models.Shortcut(
            id: shortcutData.id,
            name: shortcutData.name,
            collection: shortcutData.collection,
            url: shortcutData.url,
            color: shortcutData.color,
            imageUrl: shortcutData.imageUrl,
          ),
        )
        .watch();

    return shotrcutsStream;
  }

  @override
  Stream<List<models.Collection>> watchCollections() {
    final statement = _database.select(_database.collection);

    final stream = statement
        .map<models.Collection>(
          (data) => models.Collection(
            id: data.id,
            name: data.name,
          ),
        )
        .watch();

    return stream;
  }

  @override
  Future<void> updateCollection(int id, String name) {
    // TODO: implement updateCollection
    throw UnimplementedError();
  }

  @override
  Future<void> updateShortcut(int id, String name, String url, int collection,
      String? color, String? imageUrl) {
    // TODO: implement updateShortcut
    throw UnimplementedError();
  }
  
}
