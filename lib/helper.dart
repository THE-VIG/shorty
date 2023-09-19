import 'package:shorty/models/models.dart';

abstract class Helper {
  //collections
  Future<void> addCollection(String name);
  Future<void> updateCollection(int id, String name);
  Future<void> deleteCollection(int id);
  Future<Collection> getCollection(int id);
  Future<List<Collection>> getCollections();

  //shortcuts
  Future<void> addShortcut(
    String name,
    String url,
    int collection,
    String? color,
    String? imageUrl,
  );
  Future<void> updateShortcut(
    int id,
    String name,
    String url,
    int collection,
    String? color,
    String? imageUrl,
  );
  Future<void> deleteShortcut(int id);
  Future<Shortcut> getShortcut(int id);
  Stream<List<Shortcut>> watchShortcuts(int collectionId);
  Future<List<Shortcut>> getShortcuts(int collectionId);
}
