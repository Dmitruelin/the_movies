// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
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

  FilmDao? _filmDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
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
            'CREATE TABLE IF NOT EXISTS `Film` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `movieId` INTEGER NOT NULL, `name` TEXT, `description` TEXT, `launchOn` TEXT, `bannerPath` TEXT, `posterPath` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FilmDao get filmDao {
    return _filmDaoInstance ??= _$FilmDao(database, changeListener);
  }
}

class _$FilmDao extends FilmDao {
  _$FilmDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _filmInsertionAdapter = InsertionAdapter(
            database,
            'Film',
            (Film item) => <String, Object?>{
                  'id': item.id,
                  'movieId': item.movieId,
                  'name': item.name,
                  'description': item.description,
                  'launchOn': item.launchOn,
                  'bannerPath': item.bannerPath,
                  'posterPath': item.posterPath
                },
            changeListener),
        _filmUpdateAdapter = UpdateAdapter(
            database,
            'Film',
            ['id'],
            (Film item) => <String, Object?>{
                  'id': item.id,
                  'movieId': item.movieId,
                  'name': item.name,
                  'description': item.description,
                  'launchOn': item.launchOn,
                  'bannerPath': item.bannerPath,
                  'posterPath': item.posterPath
                },
            changeListener),
        _filmDeletionAdapter = DeletionAdapter(
            database,
            'Film',
            ['id'],
            (Film item) => <String, Object?>{
                  'id': item.id,
                  'movieId': item.movieId,
                  'name': item.name,
                  'description': item.description,
                  'launchOn': item.launchOn,
                  'bannerPath': item.bannerPath,
                  'posterPath': item.posterPath
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Film> _filmInsertionAdapter;

  final UpdateAdapter<Film> _filmUpdateAdapter;

  final DeletionAdapter<Film> _filmDeletionAdapter;

  @override
  Future<List<Film>> findAllFilms() async {
    return _queryAdapter.queryList('SELECT * FROM film',
        mapper: (Map<String, Object?> row) => Film(
            movieId: row['movieId'] as int,
            id: row['id'] as int?,
            description: row['description'] as String?,
            bannerPath: row['bannerPath'] as String?,
            posterPath: row['posterPath'] as String?,
            launchOn: row['launchOn'] as String?,
            name: row['name'] as String?));
  }

  @override
  Stream<Film?> findFilmById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM film WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Film(
            movieId: row['movieId'] as int,
            id: row['id'] as int?,
            description: row['description'] as String?,
            bannerPath: row['bannerPath'] as String?,
            posterPath: row['posterPath'] as String?,
            launchOn: row['launchOn'] as String?,
            name: row['name'] as String?),
        arguments: [id],
        queryableName: 'Film',
        isView: false);
  }

  @override
  Stream<List<Film>> findAllFilmsAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM film',
        mapper: (Map<String, Object?> row) => Film(
            movieId: row['movieId'] as int,
            id: row['id'] as int?,
            description: row['description'] as String?,
            bannerPath: row['bannerPath'] as String?,
            posterPath: row['posterPath'] as String?,
            launchOn: row['launchOn'] as String?,
            name: row['name'] as String?),
        queryableName: 'Film',
        isView: false);
  }

  @override
  Future<void> insertFilm(Film film) async {
    await _filmInsertionAdapter.insert(film, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateFilm(Film film) async {
    await _filmUpdateAdapter.update(film, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateFilms(List<Film> films) async {
    await _filmUpdateAdapter.updateList(films, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteFilm(Film film) async {
    await _filmDeletionAdapter.delete(film);
  }

  @override
  Future<void> deleteFilms(List<Film> films) async {
    await _filmDeletionAdapter.deleteList(films);
  }
}
