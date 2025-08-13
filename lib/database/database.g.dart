// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MovementDao? _movementDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Movement` (`id` INTEGER, `description` TEXT NOT NULL, `amount` INTEGER NOT NULL, `incomeDate` INTEGER, `dueDate` INTEGER, `startDate` INTEGER, `endDate` INTEGER, `type` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MovementDao get movementDao {
    return _movementDaoInstance ??= _$MovementDao(database, changeListener);
  }
}

class _$MovementDao extends MovementDao {
  _$MovementDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _movementInsertionAdapter = InsertionAdapter(
            database,
            'Movement',
            (Movement item) => <String, Object?>{
                  'id': item.id,
                  'description': item.description,
                  'amount': item.amount,
                  'incomeDate': _dateTimeConverter.encode(item.incomeDate),
                  'dueDate': _dateTimeConverter.encode(item.dueDate),
                  'startDate': _dateTimeConverter.encode(item.startDate),
                  'endDate': _dateTimeConverter.encode(item.endDate),
                  'type': item.type.index
                }),
        _movementUpdateAdapter = UpdateAdapter(
            database,
            'Movement',
            ['id'],
            (Movement item) => <String, Object?>{
                  'id': item.id,
                  'description': item.description,
                  'amount': item.amount,
                  'incomeDate': _dateTimeConverter.encode(item.incomeDate),
                  'dueDate': _dateTimeConverter.encode(item.dueDate),
                  'startDate': _dateTimeConverter.encode(item.startDate),
                  'endDate': _dateTimeConverter.encode(item.endDate),
                  'type': item.type.index
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Movement> _movementInsertionAdapter;

  final UpdateAdapter<Movement> _movementUpdateAdapter;

  @override
  Future<List<Movement>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM Movement',
        mapper: (Map<String, Object?> row) => Movement(
            id: row['id'] as int?,
            description: row['description'] as String,
            amount: row['amount'] as int,
            incomeDate: _dateTimeConverter.decode(row['incomeDate'] as int?),
            dueDate: _dateTimeConverter.decode(row['dueDate'] as int?),
            startDate: _dateTimeConverter.decode(row['startDate'] as int?),
            endDate: _dateTimeConverter.decode(row['endDate'] as int?),
            type: MovementType.values[row['type'] as int]));
  }

  @override
  Future<Movement?> findById(int id) async {
    return _queryAdapter.query('SELECT * FROM Movement WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Movement(
            id: row['id'] as int?,
            description: row['description'] as String,
            amount: row['amount'] as int,
            incomeDate: _dateTimeConverter.decode(row['incomeDate'] as int?),
            dueDate: _dateTimeConverter.decode(row['dueDate'] as int?),
            startDate: _dateTimeConverter.decode(row['startDate'] as int?),
            endDate: _dateTimeConverter.decode(row['endDate'] as int?),
            type: MovementType.values[row['type'] as int]),
        arguments: [id]);
  }

  @override
  Future<List<Movement>> findByMonthYear(String dateTime) async {
    return _queryAdapter.queryList(
        'SELECT *   FROM Movement   WHERE ?1   BETWEEN strftime(\'%Y-%m\', startDate / 1000, \'unixepoch\')   AND COALESCE(strftime(\'%Y-%m\', endDate / 1000, \'unixepoch\'), \'9999-12\');',
        mapper: (Map<String, Object?> row) => Movement(id: row['id'] as int?, description: row['description'] as String, amount: row['amount'] as int, incomeDate: _dateTimeConverter.decode(row['incomeDate'] as int?), dueDate: _dateTimeConverter.decode(row['dueDate'] as int?), startDate: _dateTimeConverter.decode(row['startDate'] as int?), endDate: _dateTimeConverter.decode(row['endDate'] as int?), type: MovementType.values[row['type'] as int]),
        arguments: [dateTime]);
  }

  @override
  Future<void> deleteById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM Movement WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> insertMovement(Movement movement) async {
    await _movementInsertionAdapter.insert(movement, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateMovement(Movement movement) async {
    await _movementUpdateAdapter.update(movement, OnConflictStrategy.abort);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
final _movementTypeConverter = MovementTypeConverter();
