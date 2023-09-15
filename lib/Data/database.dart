import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class Collection extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

class Shortcut extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 20)();
  TextColumn get url => text()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get color => text().nullable()();
  IntColumn get collection => integer()();
}

@DriftDatabase(tables: [Shortcut, Collection])
class Database extends _$MyDatabase {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
