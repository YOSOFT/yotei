// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Board extends DataClass implements Insertable<Board> {
  final int id;
  final String name;
  final String description;
  final int category;
  final DateTime lastUpdated;
  Board(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.category,
      this.lastUpdated});
  factory Board.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Board(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      category:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}category']),
      lastUpdated: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}last_updated']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<int>(category);
    }
    if (!nullToAbsent || lastUpdated != null) {
      map['last_updated'] = Variable<DateTime>(lastUpdated);
    }
    return map;
  }

  BoardsCompanion toCompanion(bool nullToAbsent) {
    return BoardsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      lastUpdated: lastUpdated == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdated),
    );
  }

  factory Board.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Board(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      category: serializer.fromJson<int>(json['category']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'category': serializer.toJson<int>(category),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  Board copyWith(
          {int id,
          String name,
          String description,
          int category,
          DateTime lastUpdated}) =>
      Board(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        category: category ?? this.category,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  @override
  String toString() {
    return (StringBuffer('Board(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(description.hashCode,
              $mrjc(category.hashCode, lastUpdated.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Board &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.category == this.category &&
          other.lastUpdated == this.lastUpdated);
}

class BoardsCompanion extends UpdateCompanion<Board> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<int> category;
  final Value<DateTime> lastUpdated;
  const BoardsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  BoardsCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required String description,
    @required int category,
    this.lastUpdated = const Value.absent(),
  })  : name = Value(name),
        description = Value(description),
        category = Value(category);
  static Insertable<Board> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> description,
    Expression<int> category,
    Expression<DateTime> lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  BoardsCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> description,
      Value<int> category,
      Value<DateTime> lastUpdated}) {
    return BoardsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      lastUpdated: lastUpdated ?? this.lastUpdated,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<int>(category.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BoardsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

class $BoardsTable extends Boards with TableInfo<$BoardsTable, Board> {
  final GeneratedDatabase _db;
  final String _alias;
  $BoardsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 255);
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn('description', $tableName, false,
        minTextLength: 1);
  }

  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  GeneratedIntColumn _category;
  @override
  GeneratedIntColumn get category => _category ??= _constructCategory();
  GeneratedIntColumn _constructCategory() {
    return GeneratedIntColumn(
      'category',
      $tableName,
      false,
    );
  }

  final VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  GeneratedDateTimeColumn _lastUpdated;
  @override
  GeneratedDateTimeColumn get lastUpdated =>
      _lastUpdated ??= _constructLastUpdated();
  GeneratedDateTimeColumn _constructLastUpdated() {
    return GeneratedDateTimeColumn(
      'last_updated',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, category, lastUpdated];
  @override
  $BoardsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'boards';
  @override
  final String actualTableName = 'boards';
  @override
  VerificationContext validateIntegrity(Insertable<Board> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category'], _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated'], _lastUpdatedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Board map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Board.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $BoardsTable createAlias(String alias) {
    return $BoardsTable(_db, alias);
  }
}

class BoardCategoryData extends DataClass
    implements Insertable<BoardCategoryData> {
  final int id;
  final String name;
  BoardCategoryData({@required this.id, @required this.name});
  factory BoardCategoryData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return BoardCategoryData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    return map;
  }

  BoardCategoryCompanion toCompanion(bool nullToAbsent) {
    return BoardCategoryCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  factory BoardCategoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return BoardCategoryData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  BoardCategoryData copyWith({int id, String name}) => BoardCategoryData(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('BoardCategoryData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, name.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is BoardCategoryData &&
          other.id == this.id &&
          other.name == this.name);
}

class BoardCategoryCompanion extends UpdateCompanion<BoardCategoryData> {
  final Value<int> id;
  final Value<String> name;
  const BoardCategoryCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  BoardCategoryCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
  }) : name = Value(name);
  static Insertable<BoardCategoryData> custom({
    Expression<int> id,
    Expression<String> name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  BoardCategoryCompanion copyWith({Value<int> id, Value<String> name}) {
    return BoardCategoryCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BoardCategoryCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $BoardCategoryTable extends BoardCategory
    with TableInfo<$BoardCategoryTable, BoardCategoryData> {
  final GeneratedDatabase _db;
  final String _alias;
  $BoardCategoryTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 255);
  }

  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  $BoardCategoryTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'board_category';
  @override
  final String actualTableName = 'board_category';
  @override
  VerificationContext validateIntegrity(Insertable<BoardCategoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BoardCategoryData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return BoardCategoryData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $BoardCategoryTable createAlias(String alias) {
    return $BoardCategoryTable(_db, alias);
  }
}

class PanelData extends DataClass implements Insertable<PanelData> {
  final int id;
  final String name;
  final String description;
  final int boardId;
  final int order;
  final DateTime lastUpdated;
  PanelData(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.boardId,
      @required this.order,
      this.lastUpdated});
  factory PanelData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return PanelData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      boardId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}board_id']),
      order: intType.mapFromDatabaseResponse(data['${effectivePrefix}order']),
      lastUpdated: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}last_updated']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || boardId != null) {
      map['board_id'] = Variable<int>(boardId);
    }
    if (!nullToAbsent || order != null) {
      map['order'] = Variable<int>(order);
    }
    if (!nullToAbsent || lastUpdated != null) {
      map['last_updated'] = Variable<DateTime>(lastUpdated);
    }
    return map;
  }

  PanelCompanion toCompanion(bool nullToAbsent) {
    return PanelCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      boardId: boardId == null && nullToAbsent
          ? const Value.absent()
          : Value(boardId),
      order:
          order == null && nullToAbsent ? const Value.absent() : Value(order),
      lastUpdated: lastUpdated == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdated),
    );
  }

  factory PanelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PanelData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      boardId: serializer.fromJson<int>(json['boardId']),
      order: serializer.fromJson<int>(json['order']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'boardId': serializer.toJson<int>(boardId),
      'order': serializer.toJson<int>(order),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  PanelData copyWith(
          {int id,
          String name,
          String description,
          int boardId,
          int order,
          DateTime lastUpdated}) =>
      PanelData(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        boardId: boardId ?? this.boardId,
        order: order ?? this.order,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  @override
  String toString() {
    return (StringBuffer('PanelData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('boardId: $boardId, ')
          ..write('order: $order, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              description.hashCode,
              $mrjc(boardId.hashCode,
                  $mrjc(order.hashCode, lastUpdated.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is PanelData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.boardId == this.boardId &&
          other.order == this.order &&
          other.lastUpdated == this.lastUpdated);
}

class PanelCompanion extends UpdateCompanion<PanelData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<int> boardId;
  final Value<int> order;
  final Value<DateTime> lastUpdated;
  const PanelCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.boardId = const Value.absent(),
    this.order = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  PanelCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required String description,
    @required int boardId,
    @required int order,
    this.lastUpdated = const Value.absent(),
  })  : name = Value(name),
        description = Value(description),
        boardId = Value(boardId),
        order = Value(order);
  static Insertable<PanelData> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> description,
    Expression<int> boardId,
    Expression<int> order,
    Expression<DateTime> lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (boardId != null) 'board_id': boardId,
      if (order != null) 'order': order,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  PanelCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> description,
      Value<int> boardId,
      Value<int> order,
      Value<DateTime> lastUpdated}) {
    return PanelCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      boardId: boardId ?? this.boardId,
      order: order ?? this.order,
      lastUpdated: lastUpdated ?? this.lastUpdated,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (boardId.present) {
      map['board_id'] = Variable<int>(boardId.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PanelCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('boardId: $boardId, ')
          ..write('order: $order, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

class $PanelTable extends Panel with TableInfo<$PanelTable, PanelData> {
  final GeneratedDatabase _db;
  final String _alias;
  $PanelTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 255);
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn('description', $tableName, false,
        minTextLength: 1);
  }

  final VerificationMeta _boardIdMeta = const VerificationMeta('boardId');
  GeneratedIntColumn _boardId;
  @override
  GeneratedIntColumn get boardId => _boardId ??= _constructBoardId();
  GeneratedIntColumn _constructBoardId() {
    return GeneratedIntColumn(
      'board_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _orderMeta = const VerificationMeta('order');
  GeneratedIntColumn _order;
  @override
  GeneratedIntColumn get order => _order ??= _constructOrder();
  GeneratedIntColumn _constructOrder() {
    return GeneratedIntColumn(
      'order',
      $tableName,
      false,
    );
  }

  final VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  GeneratedDateTimeColumn _lastUpdated;
  @override
  GeneratedDateTimeColumn get lastUpdated =>
      _lastUpdated ??= _constructLastUpdated();
  GeneratedDateTimeColumn _constructLastUpdated() {
    return GeneratedDateTimeColumn(
      'last_updated',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, boardId, order, lastUpdated];
  @override
  $PanelTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'panel';
  @override
  final String actualTableName = 'panel';
  @override
  VerificationContext validateIntegrity(Insertable<PanelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('board_id')) {
      context.handle(_boardIdMeta,
          boardId.isAcceptableOrUnknown(data['board_id'], _boardIdMeta));
    } else if (isInserting) {
      context.missing(_boardIdMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order'], _orderMeta));
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated'], _lastUpdatedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PanelData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return PanelData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PanelTable createAlias(String alias) {
    return $PanelTable(_db, alias);
  }
}

class PanelItemData extends DataClass implements Insertable<PanelItemData> {
  final int id;
  final String name;
  final String description;
  final int panelId;
  final int order;
  final DateTime lastUpdated;
  PanelItemData(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.panelId,
      @required this.order,
      this.lastUpdated});
  factory PanelItemData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return PanelItemData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      panelId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}panel_id']),
      order: intType.mapFromDatabaseResponse(data['${effectivePrefix}order']),
      lastUpdated: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}last_updated']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || panelId != null) {
      map['panel_id'] = Variable<int>(panelId);
    }
    if (!nullToAbsent || order != null) {
      map['order'] = Variable<int>(order);
    }
    if (!nullToAbsent || lastUpdated != null) {
      map['last_updated'] = Variable<DateTime>(lastUpdated);
    }
    return map;
  }

  PanelItemCompanion toCompanion(bool nullToAbsent) {
    return PanelItemCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      panelId: panelId == null && nullToAbsent
          ? const Value.absent()
          : Value(panelId),
      order:
          order == null && nullToAbsent ? const Value.absent() : Value(order),
      lastUpdated: lastUpdated == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdated),
    );
  }

  factory PanelItemData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PanelItemData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      panelId: serializer.fromJson<int>(json['panelId']),
      order: serializer.fromJson<int>(json['order']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'panelId': serializer.toJson<int>(panelId),
      'order': serializer.toJson<int>(order),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  PanelItemData copyWith(
          {int id,
          String name,
          String description,
          int panelId,
          int order,
          DateTime lastUpdated}) =>
      PanelItemData(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        panelId: panelId ?? this.panelId,
        order: order ?? this.order,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  @override
  String toString() {
    return (StringBuffer('PanelItemData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('panelId: $panelId, ')
          ..write('order: $order, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              description.hashCode,
              $mrjc(panelId.hashCode,
                  $mrjc(order.hashCode, lastUpdated.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is PanelItemData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.panelId == this.panelId &&
          other.order == this.order &&
          other.lastUpdated == this.lastUpdated);
}

class PanelItemCompanion extends UpdateCompanion<PanelItemData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<int> panelId;
  final Value<int> order;
  final Value<DateTime> lastUpdated;
  const PanelItemCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.panelId = const Value.absent(),
    this.order = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  PanelItemCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required String description,
    @required int panelId,
    @required int order,
    this.lastUpdated = const Value.absent(),
  })  : name = Value(name),
        description = Value(description),
        panelId = Value(panelId),
        order = Value(order);
  static Insertable<PanelItemData> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> description,
    Expression<int> panelId,
    Expression<int> order,
    Expression<DateTime> lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (panelId != null) 'panel_id': panelId,
      if (order != null) 'order': order,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  PanelItemCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> description,
      Value<int> panelId,
      Value<int> order,
      Value<DateTime> lastUpdated}) {
    return PanelItemCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      panelId: panelId ?? this.panelId,
      order: order ?? this.order,
      lastUpdated: lastUpdated ?? this.lastUpdated,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (panelId.present) {
      map['panel_id'] = Variable<int>(panelId.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PanelItemCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('panelId: $panelId, ')
          ..write('order: $order, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

class $PanelItemTable extends PanelItem
    with TableInfo<$PanelItemTable, PanelItemData> {
  final GeneratedDatabase _db;
  final String _alias;
  $PanelItemTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 255);
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn('description', $tableName, false,
        minTextLength: 1);
  }

  final VerificationMeta _panelIdMeta = const VerificationMeta('panelId');
  GeneratedIntColumn _panelId;
  @override
  GeneratedIntColumn get panelId => _panelId ??= _constructPanelId();
  GeneratedIntColumn _constructPanelId() {
    return GeneratedIntColumn(
      'panel_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _orderMeta = const VerificationMeta('order');
  GeneratedIntColumn _order;
  @override
  GeneratedIntColumn get order => _order ??= _constructOrder();
  GeneratedIntColumn _constructOrder() {
    return GeneratedIntColumn(
      'order',
      $tableName,
      false,
    );
  }

  final VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  GeneratedDateTimeColumn _lastUpdated;
  @override
  GeneratedDateTimeColumn get lastUpdated =>
      _lastUpdated ??= _constructLastUpdated();
  GeneratedDateTimeColumn _constructLastUpdated() {
    return GeneratedDateTimeColumn(
      'last_updated',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, panelId, order, lastUpdated];
  @override
  $PanelItemTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'panel_item';
  @override
  final String actualTableName = 'panel_item';
  @override
  VerificationContext validateIntegrity(Insertable<PanelItemData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('panel_id')) {
      context.handle(_panelIdMeta,
          panelId.isAcceptableOrUnknown(data['panel_id'], _panelIdMeta));
    } else if (isInserting) {
      context.missing(_panelIdMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order'], _orderMeta));
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated'], _lastUpdatedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PanelItemData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return PanelItemData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PanelItemTable createAlias(String alias) {
    return $PanelItemTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $BoardsTable _boards;
  $BoardsTable get boards => _boards ??= $BoardsTable(this);
  $BoardCategoryTable _boardCategory;
  $BoardCategoryTable get boardCategory =>
      _boardCategory ??= $BoardCategoryTable(this);
  $PanelTable _panel;
  $PanelTable get panel => _panel ??= $PanelTable(this);
  $PanelItemTable _panelItem;
  $PanelItemTable get panelItem => _panelItem ??= $PanelItemTable(this);
  BoardsDao _boardsDao;
  BoardsDao get boardsDao => _boardsDao ??= BoardsDao(this as AppDatabase);
  CategoryDao _categoryDao;
  CategoryDao get categoryDao =>
      _categoryDao ??= CategoryDao(this as AppDatabase);
  PanelDao _panelDao;
  PanelDao get panelDao => _panelDao ??= PanelDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [boards, boardCategory, panel, panelItem];
}
