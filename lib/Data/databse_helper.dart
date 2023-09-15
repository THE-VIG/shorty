import 'package:drift/drift.dart';
import 'package:shorty/Data/database.dart';
import 'package:shorty/helper.dart';
import 'package:shorty/models/models.dart' as models;

final database = Database();

class DatabaseHelper extends Helper {
  @override
  Future<void> addCollection(String name) async {
    await database.into(database.collection).insert(
          CollectionCompanion.insert(
            name: name,
          ),
        );
  }

  @override
  Future<void> addShortcut(String name, String url, int collection,
      String? color, String? imageUrl) {
    // TODO: implement addShortcut
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCollection(int id) {
    // TODO: implement deleteCollection
    throw UnimplementedError();
  }

  @override
  Future<void> deleteShortcut(int id) {
    // TODO: implement deleteShortcut
    throw UnimplementedError();
  }

  @override
  Future<models.Collecion> getCollection(int id) {
    // TODO: implement getCollection
    throw UnimplementedError();
  }

  @override
  Future<List<models.Collecion>> getCollections() async {
    final response = await database.collection.select().get();
    final collections = <models.Collecion>[];

    for (var collection in response) {
      collections.add(
        models.Collecion(
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
  Future<List<models.Shortcut>> getShortcuts() {
    // TODO: implement getShortcuts
    throw UnimplementedError();
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
