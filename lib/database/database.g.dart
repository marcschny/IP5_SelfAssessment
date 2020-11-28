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

  AssessmentRepository _assessmentRepositoryInstance;

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
            'CREATE TABLE IF NOT EXISTS `Question` (`id` INTEGER, `question_number` TEXT, `question` TEXT, `subquestion` TEXT, `assessment_id` INTEGER, FOREIGN KEY (`assessment_id`) REFERENCES `Assessment` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`question_number`))');
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

  @override
  AssessmentRepository get assessmentRepository {
    return _assessmentRepositoryInstance ??=
        _$AssessmentRepository(database, changeListener);
  }
}

class _$AssessmentRepository extends AssessmentRepository {
  _$AssessmentRepository(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _answerInsertionAdapter = InsertionAdapter(
            database,
            'Answer',
            (Answer item) => <String, dynamic>{
                  'id': item.id,
                  'answer': item.answer,
                  'question_number': item.question_number,
                  'assessment_id': item.assessment_id
                }),
        _assessmentInsertionAdapter = InsertionAdapter(
            database,
            'Assessment',
            (Assessment item) => <String, dynamic>{
                  'id': item.id,
                  'date_created': item.date_created,
                  'date_finished': item.date_finished
                }),
        _changeProjectInsertionAdapter = InsertionAdapter(
            database,
            'ChangeProject',
            (ChangeProject item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'date_started': item.date_started,
                  'date_finished': item.date_finished,
                  'assessment_id': item.assessment_id
                }),
        _noteInsertionAdapter = InsertionAdapter(
            database,
            'Note',
            (Note item) => <String, dynamic>{
                  'id': item.id,
                  'note': item.note,
                  'date_created': item.date_created,
                  'project_id': item.project_id,
                  'assessment_id': item.assessment_id
                }),
        _networkCardInsertionAdapter = InsertionAdapter(
            database,
            'NetworkCard',
            (NetworkCard item) => <String, dynamic>{
                  'id': item.id,
                  'noLifeAreas': item.noLifeAreas,
                  'lifeAreas': item.lifeAreas,
                  'assessment_id': item.assessment_id
                }),
        _personInsertionAdapter = InsertionAdapter(
            database,
            'Person',
            (Person item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'icon': item.icon,
                  'lifeArea': item.lifeArea,
                  'distance': item.distance,
                  'network_id': item.network_id,
                  'assessment_id': item.assessment_id
                }),
        _questionUpdateAdapter = UpdateAdapter(
            database,
            'Question',
            ['question_number'],
            (Question item) => <String, dynamic>{
                  'id': item.id,
                  'question_number': item.question_number,
                  'question': item.question,
                  'subquestion': item.subquestion,
                  'assessment_id': item.assessment_id
                }),
        _answerUpdateAdapter = UpdateAdapter(
            database,
            'Answer',
            ['id'],
            (Answer item) => <String, dynamic>{
                  'id': item.id,
                  'answer': item.answer,
                  'question_number': item.question_number,
                  'assessment_id': item.assessment_id
                }),
        _assessmentUpdateAdapter = UpdateAdapter(
            database,
            'Assessment',
            ['id'],
            (Assessment item) => <String, dynamic>{
                  'id': item.id,
                  'date_created': item.date_created,
                  'date_finished': item.date_finished
                }),
        _changeProjectUpdateAdapter = UpdateAdapter(
            database,
            'ChangeProject',
            ['id'],
            (ChangeProject item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'date_started': item.date_started,
                  'date_finished': item.date_finished,
                  'assessment_id': item.assessment_id
                }),
        _noteUpdateAdapter = UpdateAdapter(
            database,
            'Note',
            ['id'],
            (Note item) => <String, dynamic>{
                  'id': item.id,
                  'note': item.note,
                  'date_created': item.date_created,
                  'project_id': item.project_id,
                  'assessment_id': item.assessment_id
                }),
        _networkCardUpdateAdapter = UpdateAdapter(
            database,
            'NetworkCard',
            ['id'],
            (NetworkCard item) => <String, dynamic>{
                  'id': item.id,
                  'noLifeAreas': item.noLifeAreas,
                  'lifeAreas': item.lifeAreas,
                  'assessment_id': item.assessment_id
                }),
        _personUpdateAdapter = UpdateAdapter(
            database,
            'Person',
            ['id'],
            (Person item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'icon': item.icon,
                  'lifeArea': item.lifeArea,
                  'distance': item.distance,
                  'network_id': item.network_id,
                  'assessment_id': item.assessment_id
                }),
        _answerDeletionAdapter = DeletionAdapter(
            database,
            'Answer',
            ['id'],
            (Answer item) => <String, dynamic>{
                  'id': item.id,
                  'answer': item.answer,
                  'question_number': item.question_number,
                  'assessment_id': item.assessment_id
                }),
        _assessmentDeletionAdapter = DeletionAdapter(
            database,
            'Assessment',
            ['id'],
            (Assessment item) => <String, dynamic>{
                  'id': item.id,
                  'date_created': item.date_created,
                  'date_finished': item.date_finished
                }),
        _changeProjectDeletionAdapter = DeletionAdapter(
            database,
            'ChangeProject',
            ['id'],
            (ChangeProject item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'date_started': item.date_started,
                  'date_finished': item.date_finished,
                  'assessment_id': item.assessment_id
                }),
        _noteDeletionAdapter = DeletionAdapter(
            database,
            'Note',
            ['id'],
            (Note item) => <String, dynamic>{
                  'id': item.id,
                  'note': item.note,
                  'date_created': item.date_created,
                  'project_id': item.project_id,
                  'assessment_id': item.assessment_id
                }),
        _networkCardDeletionAdapter = DeletionAdapter(
            database,
            'NetworkCard',
            ['id'],
            (NetworkCard item) => <String, dynamic>{
                  'id': item.id,
                  'noLifeAreas': item.noLifeAreas,
                  'lifeAreas': item.lifeAreas,
                  'assessment_id': item.assessment_id
                }),
        _personDeletionAdapter = DeletionAdapter(
            database,
            'Person',
            ['id'],
            (Person item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'icon': item.icon,
                  'lifeArea': item.lifeArea,
                  'distance': item.distance,
                  'network_id': item.network_id,
                  'assessment_id': item.assessment_id
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Answer> _answerInsertionAdapter;

  final InsertionAdapter<Assessment> _assessmentInsertionAdapter;

  final InsertionAdapter<ChangeProject> _changeProjectInsertionAdapter;

  final InsertionAdapter<Note> _noteInsertionAdapter;

  final InsertionAdapter<NetworkCard> _networkCardInsertionAdapter;

  final InsertionAdapter<Person> _personInsertionAdapter;

  final UpdateAdapter<Question> _questionUpdateAdapter;

  final UpdateAdapter<Answer> _answerUpdateAdapter;

  final UpdateAdapter<Assessment> _assessmentUpdateAdapter;

  final UpdateAdapter<ChangeProject> _changeProjectUpdateAdapter;

  final UpdateAdapter<Note> _noteUpdateAdapter;

  final UpdateAdapter<NetworkCard> _networkCardUpdateAdapter;

  final UpdateAdapter<Person> _personUpdateAdapter;

  final DeletionAdapter<Answer> _answerDeletionAdapter;

  final DeletionAdapter<Assessment> _assessmentDeletionAdapter;

  final DeletionAdapter<ChangeProject> _changeProjectDeletionAdapter;

  final DeletionAdapter<Note> _noteDeletionAdapter;

  final DeletionAdapter<NetworkCard> _networkCardDeletionAdapter;

  final DeletionAdapter<Person> _personDeletionAdapter;

  @override
  Future<List<Question>> getAllQuestions() async {
    return _queryAdapter.queryList('SELECT * FROM Question',
        mapper: (Map<String, dynamic> row) => Question(
            row['id'] as int,
            row['question_number'] as String,
            row['question'] as String,
            row['subquestion'] as String,
            row['assessment_id'] as int));
  }

  @override
  Future<List<Question>> getAllQuestionsByAssessment(int assessment_id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Question WHERE assessment_id = ?',
        arguments: <dynamic>[assessment_id],
        mapper: (Map<String, dynamic> row) => Question(
            row['id'] as int,
            row['question_number'] as String,
            row['question'] as String,
            row['subquestion'] as String,
            row['assessment_id'] as int));
  }

  @override
  Future<Question> findQuestion(String question_number) async {
    return _queryAdapter.query(
        'SELECT * FROM Question WHERE question_number = ?',
        arguments: <dynamic>[question_number],
        mapper: (Map<String, dynamic> row) => Question(
            row['id'] as int,
            row['question_number'] as String,
            row['question'] as String,
            row['subquestion'] as String,
            row['assessment_id'] as int));
  }

  @override
  Future<Answer> findAnswer(String question_number, int assessmentId) async {
    return _queryAdapter.query(
        'SELECT * FROM Answer WHERE question_number = ? AND assessment_id = ?',
        arguments: <dynamic>[question_number, assessmentId],
        mapper: (Map<String, dynamic> row) => Answer(
            row['id'] as int,
            row['answer'] as String,
            row['question_number'] as String,
            row['assessment_id'] as int));
  }

  @override
  Future<List<Answer>> getAllAnswersByAssessment(int assessment_id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Answer WHERE assessment_id = ?',
        arguments: <dynamic>[assessment_id],
        mapper: (Map<String, dynamic> row) => Answer(
            row['id'] as int,
            row['answer'] as String,
            row['question_number'] as String,
            row['assessment_id'] as int));
  }

  @override
  Future<List<Answer>> getSurveyAnswers() async {
    return _queryAdapter.queryList(
        'SELECT * FROM Answer WHERE answer="Kriege ich hin und wieder hin" OR answer="Schaffe ich selten"',
        mapper: (Map<String, dynamic> row) => Answer(
            row['id'] as int,
            row['answer'] as String,
            row['question_number'] as String,
            row['assessment_id'] as int));
  }

  @override
  Future<List<Assessment>> getAllAssessments() async {
    return _queryAdapter.queryList('SELECT * FROM Assessment',
        mapper: (Map<String, dynamic> row) => Assessment(row['id'] as int,
            row['date_created'] as String, row['date_finished'] as String));
  }

  @override
  Future<Assessment> findAssessment(int id) async {
    return _queryAdapter.query('SELECT * FROM Assessment WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Assessment(row['id'] as int,
            row['date_created'] as String, row['date_finished'] as String));
  }

  @override
  Future<List<ChangeProject>> getAllChangeProjects() async {
    return _queryAdapter.queryList('SELECT * FROM ChangeProject',
        mapper: (Map<String, dynamic> row) => ChangeProject(
            row['id'] as int,
            row['title'] as String,
            row['date_started'] as String,
            row['date_finished'] as String,
            row['assessment_id'] as int));
  }

  @override
  Future<ChangeProject> findChangeProject(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM ChangeProject WHERE assessment_id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => ChangeProject(
            row['id'] as int,
            row['title'] as String,
            row['date_started'] as String,
            row['date_finished'] as String,
            row['assessment_id'] as int));
  }

  @override
  Future<List<Note>> getAllNotes() async {
    return _queryAdapter.queryList('SELECT * FROM Note',
        mapper: (Map<String, dynamic> row) => Note(
            row['id'] as int,
            row['note'] as String,
            row['date_created'] as String,
            row['project_id'] as int,
            row['assessment_id'] as int));
  }

  @override
  Future<List<Note>> getAllNotesByAssessment(int pid, int aid) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Note WHERE project_id = ? AND assessment_id = ?',
        arguments: <dynamic>[pid, aid],
        mapper: (Map<String, dynamic> row) => Note(
            row['id'] as int,
            row['note'] as String,
            row['date_created'] as String,
            row['project_id'] as int,
            row['assessment_id'] as int));
  }

  @override
  Future<Note> findNote(int id) async {
    return _queryAdapter.query('SELECT * FROM Note WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Note(
            row['id'] as int,
            row['note'] as String,
            row['date_created'] as String,
            row['project_id'] as int,
            row['assessment_id'] as int));
  }

  @override
  Future<List<NetworkCard>> getAllNetworkCards() async {
    return _queryAdapter.queryList('SELECT * FROM NetworkCard',
        mapper: (Map<String, dynamic> row) => NetworkCard(
            row['id'] as int,
            row['assessment_id'] as int,
            row['noLifeAreas'] as int,
            row['lifeAreas'] as String));
  }

  @override
  Future<NetworkCard> findNetworkCard(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM NetworkCard WHERE assessment_id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => NetworkCard(
            row['id'] as int,
            row['assessment_id'] as int,
            row['noLifeAreas'] as int,
            row['lifeAreas'] as String));
  }

  @override
  Future<List<Person>> getAllPersons() async {
    return _queryAdapter.queryList('SELECT * FROM Person',
        mapper: (Map<String, dynamic> row) => Person(
            row['id'] as int,
            row['name'] as String,
            row['icon'] as String,
            row['lifeArea'] as String,
            row['distance'] as double,
            row['network_id'] as int,
            row['assessment_id'] as int));
  }

  @override
  Future<List<Person>> getAllPersonsByNetworkCard(int id) async {
    return _queryAdapter.queryList('SELECT * FROM Person WHERE network_id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Person(
            row['id'] as int,
            row['name'] as String,
            row['icon'] as String,
            row['lifeArea'] as String,
            row['distance'] as double,
            row['network_id'] as int,
            row['assessment_id'] as int));
  }

  @override
  Future<Person> findPerson(int id) async {
    return _queryAdapter.query('SELECT * FROM Person WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Person(
            row['id'] as int,
            row['name'] as String,
            row['icon'] as String,
            row['lifeArea'] as String,
            row['distance'] as double,
            row['network_id'] as int,
            row['assessment_id'] as int));
  }

  @override
  Future<int> insertAnswer(Answer answer) {
    return _answerInsertionAdapter.insertAndReturnId(
        answer, OnConflictStrategy.abort);
  }

  @override
  Future<int> createAssessment(Assessment assessment) {
    return _assessmentInsertionAdapter.insertAndReturnId(
        assessment, OnConflictStrategy.abort);
  }

  @override
  Future<int> createChangeProject(ChangeProject changeProject) {
    return _changeProjectInsertionAdapter.insertAndReturnId(
        changeProject, OnConflictStrategy.abort);
  }

  @override
  Future<int> createNote(Note note) {
    return _noteInsertionAdapter.insertAndReturnId(
        note, OnConflictStrategy.abort);
  }

  @override
  Future<int> createNetworkCard(NetworkCard networkCard) {
    return _networkCardInsertionAdapter.insertAndReturnId(
        networkCard, OnConflictStrategy.abort);
  }

  @override
  Future<int> createPerson(Person person) {
    return _personInsertionAdapter.insertAndReturnId(
        person, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateQuestion(Question question) {
    return _questionUpdateAdapter.updateAndReturnChangedRows(
        question, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateAnswer(Answer answer) {
    return _answerUpdateAdapter.updateAndReturnChangedRows(
        answer, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateAssessment(Assessment assessment) {
    return _assessmentUpdateAdapter.updateAndReturnChangedRows(
        assessment, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateChangeProject(ChangeProject changeProject) {
    return _changeProjectUpdateAdapter.updateAndReturnChangedRows(
        changeProject, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateNote(Note note) {
    return _noteUpdateAdapter.updateAndReturnChangedRows(
        note, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateNetworkCard(NetworkCard networkCard) {
    return _networkCardUpdateAdapter.updateAndReturnChangedRows(
        networkCard, OnConflictStrategy.abort);
  }

  @override
  Future<int> updatePerson(Person person) {
    return _personUpdateAdapter.updateAndReturnChangedRows(
        person, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteAnswer(Answer answer) {
    return _answerDeletionAdapter.deleteAndReturnChangedRows(answer);
  }

  @override
  Future<int> deleteAssessment(Assessment assessment) {
    return _assessmentDeletionAdapter.deleteAndReturnChangedRows(assessment);
  }

  @override
  Future<int> deleteChangeProject(ChangeProject changeProject) {
    return _changeProjectDeletionAdapter
        .deleteAndReturnChangedRows(changeProject);
  }

  @override
  Future<int> deleteNote(Note note) {
    return _noteDeletionAdapter.deleteAndReturnChangedRows(note);
  }

  @override
  Future<int> deleteNetworkCard(NetworkCard networkCard) {
    return _networkCardDeletionAdapter.deleteAndReturnChangedRows(networkCard);
  }

  @override
  Future<int> deletePerson(Person person) {
    return _personDeletionAdapter.deleteAndReturnChangedRows(person);
  }
}
