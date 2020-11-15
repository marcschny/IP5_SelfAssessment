// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

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

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

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
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
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
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
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
            'CREATE TABLE IF NOT EXISTS `Assessment` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `date_created` TEXT, `date_finished` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Answer` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `answer` TEXT, `question_number` TEXT, `assessment_id` INTEGER, FOREIGN KEY (`question_number`) REFERENCES `Question` (`question_number`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`assessment_id`) REFERENCES `Assessment` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Question` (`id` INTEGER, `question_number` TEXT, `answered` INTEGER, `question` TEXT, `subquestion` TEXT, `assessment_id` INTEGER, FOREIGN KEY (`assessment_id`) REFERENCES `Assessment` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`question_number`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `NetworkCard` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `noLifeAreas` INTEGER, `lifeAreas` TEXT, `assessment_id` INTEGER, FOREIGN KEY (`assessment_id`) REFERENCES `Assessment` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Person` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `icon` TEXT, `lifeArea` TEXT, `distance` REAL, `network_id` INTEGER, `assessment_id` INTEGER, FOREIGN KEY (`network_id`) REFERENCES `NetworkCard` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`assessment_id`) REFERENCES `Assessment` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ChangeProject` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `date_started` TEXT, `date_finished` TEXT, `assessment_id` INTEGER, FOREIGN KEY (`assessment_id`) REFERENCES `Assessment` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Note` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `note` TEXT, `date_created` TEXT, `project_id` INTEGER, `assessment_id` INTEGER, FOREIGN KEY (`project_id`) REFERENCES `ChangeProject` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`assessment_id`) REFERENCES `Assessment` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }
}
