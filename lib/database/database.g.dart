// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ShortcutTable extends Shortcut
    with TableInfo<$ShortcutTable, ShortcutData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShortcutTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _collectionMeta =
      const VerificationMeta('collection');
  @override
  late final GeneratedColumn<int> collection = GeneratedColumn<int>(
      'collection', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, url, imageUrl, color, collection];
  @override
  String get aliasedName => _alias ?? 'shortcut';
  @override
  String get actualTableName => 'shortcut';
  @override
  VerificationContext validateIntegrity(Insertable<ShortcutData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('collection')) {
      context.handle(
          _collectionMeta,
          collection.isAcceptableOrUnknown(
              data['collection']!, _collectionMeta));
    } else if (isInserting) {
      context.missing(_collectionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShortcutData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShortcutData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url']),
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color']),
      collection: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}collection'])!,
    );
  }

  @override
  $ShortcutTable createAlias(String alias) {
    return $ShortcutTable(attachedDatabase, alias);
  }
}

class ShortcutData extends DataClass implements Insertable<ShortcutData> {
  final int id;
  final String name;
  final String url;
  final String? imageUrl;
  final String? color;
  final int collection;
  const ShortcutData(
      {required this.id,
      required this.name,
      required this.url,
      this.imageUrl,
      this.color,
      required this.collection});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['url'] = Variable<String>(url);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    map['collection'] = Variable<int>(collection);
    return map;
  }

  ShortcutCompanion toCompanion(bool nullToAbsent) {
    return ShortcutCompanion(
      id: Value(id),
      name: Value(name),
      url: Value(url),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      collection: Value(collection),
    );
  }

  factory ShortcutData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShortcutData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      url: serializer.fromJson<String>(json['url']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      color: serializer.fromJson<String?>(json['color']),
      collection: serializer.fromJson<int>(json['collection']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'url': serializer.toJson<String>(url),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'color': serializer.toJson<String?>(color),
      'collection': serializer.toJson<int>(collection),
    };
  }

  ShortcutData copyWith(
          {int? id,
          String? name,
          String? url,
          Value<String?> imageUrl = const Value.absent(),
          Value<String?> color = const Value.absent(),
          int? collection}) =>
      ShortcutData(
        id: id ?? this.id,
        name: name ?? this.name,
        url: url ?? this.url,
        imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
        color: color.present ? color.value : this.color,
        collection: collection ?? this.collection,
      );
  @override
  String toString() {
    return (StringBuffer('ShortcutData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('url: $url, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('color: $color, ')
          ..write('collection: $collection')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, url, imageUrl, color, collection);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShortcutData &&
          other.id == this.id &&
          other.name == this.name &&
          other.url == this.url &&
          other.imageUrl == this.imageUrl &&
          other.color == this.color &&
          other.collection == this.collection);
}

class ShortcutCompanion extends UpdateCompanion<ShortcutData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> url;
  final Value<String?> imageUrl;
  final Value<String?> color;
  final Value<int> collection;
  const ShortcutCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.url = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.color = const Value.absent(),
    this.collection = const Value.absent(),
  });
  ShortcutCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String url,
    this.imageUrl = const Value.absent(),
    this.color = const Value.absent(),
    required int collection,
  })  : name = Value(name),
        url = Value(url),
        collection = Value(collection);
  static Insertable<ShortcutData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? url,
    Expression<String>? imageUrl,
    Expression<String>? color,
    Expression<int>? collection,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (url != null) 'url': url,
      if (imageUrl != null) 'image_url': imageUrl,
      if (color != null) 'color': color,
      if (collection != null) 'collection': collection,
    });
  }

  ShortcutCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? url,
      Value<String?>? imageUrl,
      Value<String?>? color,
      Value<int>? collection}) {
    return ShortcutCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      imageUrl: imageUrl ?? this.imageUrl,
      color: color ?? this.color,
      collection: collection ?? this.collection,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (collection.present) {
      map['collection'] = Variable<int>(collection.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShortcutCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('url: $url, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('color: $color, ')
          ..write('collection: $collection')
          ..write(')'))
        .toString();
  }
}

class $CollectionTable extends Collection
    with TableInfo<$CollectionTable, CollectionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CollectionTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
      'type', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [id, name, type];
  @override
  String get aliasedName => _alias ?? 'collection';
  @override
  String get actualTableName => 'collection';
  @override
  VerificationContext validateIntegrity(Insertable<CollectionData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CollectionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CollectionData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!,
    );
  }

  @override
  $CollectionTable createAlias(String alias) {
    return $CollectionTable(attachedDatabase, alias);
  }
}

class CollectionData extends DataClass implements Insertable<CollectionData> {
  final int id;
  final String name;
  final int type;
  const CollectionData(
      {required this.id, required this.name, required this.type});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<int>(type);
    return map;
  }

  CollectionCompanion toCompanion(bool nullToAbsent) {
    return CollectionCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
    );
  }

  factory CollectionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CollectionData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<int>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<int>(type),
    };
  }

  CollectionData copyWith({int? id, String? name, int? type}) => CollectionData(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
      );
  @override
  String toString() {
    return (StringBuffer('CollectionData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollectionData &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type);
}

class CollectionCompanion extends UpdateCompanion<CollectionData> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> type;
  const CollectionCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
  });
  CollectionCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.type = const Value.absent(),
  }) : name = Value(name);
  static Insertable<CollectionData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
    });
  }

  CollectionCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<int>? type}) {
    return CollectionCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollectionCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final $ShortcutTable shortcut = $ShortcutTable(this);
  late final $CollectionTable collection = $CollectionTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [shortcut, collection];
}
