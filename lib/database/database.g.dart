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
            'CREATE TABLE IF NOT EXISTS `Assessment` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `project_title` TEXT, `overall_mood` TEXT, `date_created` TEXT, `date_finished` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Answer` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `answer` TEXT, `question_number` TEXT, `assessment_id` INTEGER, FOREIGN KEY (`question_number`) REFERENCES `Question` (`question_number`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`assessment_id`) REFERENCES `Assessment` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Question` (`id` INTEGER, `question_number` TEXT, `question` TEXT, `subquestion` TEXT, `assessment_id` INTEGER, FOREIGN KEY (`assessment_id`) REFERENCES `Assessment` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`question_number`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Visualization` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `noLifeAreas` INTEGER, `lifeAreas` TEXT, `assessment_id` INTEGER, FOREIGN KEY (`assessment_id`) REFERENCES `Assessment` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Person` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `icon` TEXT, `lifeArea` TEXT, `distance` REAL, `visualization_id` INTEGER, `assessment_id` INTEGER, FOREIGN KEY (`visualization_id`) REFERENCES `Visualization` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`assessment_id`) REFERENCES `Assessment` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Experience` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `mood` TEXT, `description` TEXT, `explanation` TEXT, `date_created` TEXT, `assessment_id` INTEGER, FOREIGN KEY (`assessment_id`) REFERENCES `Assessment` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

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
                  'project_title': item.project_title,
                  'overall_mood': item.overall_mood,
                  'date_created': item.date_created,
                  'date_finished': item.date_finished
                }),
        _experienceInsertionAdapter = InsertionAdapter(
            database,
            'Experience',
            (Experience item) => <String, dynamic>{
                  'id': item.id,
                  'mood': item.mood,
                  'description': item.description,
                  'explanation': item.explanation,
                  'date_created': item.date_created,
                  'assessment_id': item.assessment_id
                }),
        _visualizationInsertionAdapter = InsertionAdapter(
            database,
            'Visualization',
            (Visualization item) => <String, dynamic>{
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
                  'visualization_id': item.visualization_id,
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
                  'project_title': item.project_title,
                  'overall_mood': item.overall_mood,
                  'date_created': item.date_created,
                  'date_finished': item.date_finished
                }),
        _experienceUpdateAdapter = UpdateAdapter(
            database,
            'Experience',
            ['id'],
            (Experience item) => <String, dynamic>{
                  'id': item.id,
                  'mood': item.mood,
                  'description': item.description,
                  'explanation': item.explanation,
                  'date_created': item.date_created,
                  'assessment_id': item.assessment_id
                }),
        _visualizationUpdateAdapter = UpdateAdapter(
            database,
            'Visualization',
            ['id'],
            (Visualization item) => <String, dynamic>{
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
                  'visualization_id': item.visualization_id,
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
                  'project_title': item.project_title,
                  'overall_mood': item.overall_mood,
                  'date_created': item.date_created,
                  'date_finished': item.date_finished
                }),
        _experienceDeletionAdapter = DeletionAdapter(
            database,
            'Experience',
            ['id'],
            (Experience item) => <String, dynamic>{
                  'id': item.id,
                  'mood': item.mood,
                  'description': item.description,
                  'explanation': item.explanation,
                  'date_created': item.date_created,
                  'assessment_id': item.assessment_id
                }),
        _visualizationDeletionAdapter = DeletionAdapter(
            database,
            'Visualization',
            ['id'],
            (Visualization item) => <String, dynamic>{
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
                  'visualization_id': item.visualization_id,
                  'assessment_id': item.assessment_id
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Answer> _answerInsertionAdapter;

  final InsertionAdapter<Assessment> _assessmentInsertionAdapter;

  final InsertionAdapter<Experience> _experienceInsertionAdapter;

  final InsertionAdapter<Visualization> _visualizationInsertionAdapter;

  final InsertionAdapter<Person> _personInsertionAdapter;

  final UpdateAdapter<Question> _questionUpdateAdapter;

  final UpdateAdapter<Answer> _answerUpdateAdapter;

  final UpdateAdapter<Assessment> _assessmentUpdateAdapter;

  final UpdateAdapter<Experience> _experienceUpdateAdapter;

  final UpdateAdapter<Visualization> _visualizationUpdateAdapter;

  final UpdateAdapter<Person> _personUpdateAdapter;

  final DeletionAdapter<Answer> _answerDeletionAdapter;

  final DeletionAdapter<Assessment> _assessmentDeletionAdapter;

  final DeletionAdapter<Experience> _experienceDeletionAdapter;

  final DeletionAdapter<Visualization> _visualizationDeletionAdapter;

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
  Future<List<Answer>> getNegSurveyAnswers(int assessmentId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Answer WHERE (answer="Kriege ich hin und wieder hin" OR answer="Schaffe ich selten") AND assessment_id = ?',
        arguments: <dynamic>[assessmentId],
        mapper: (Map<String, dynamic> row) => Answer(
            row['id'] as int,
            row['answer'] as String,
            row['question_number'] as String,
            row['assessment_id'] as int));
  }

  @override
  Future<List<Answer>> getPosSurveyAnswers(int assessmentId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Answer WHERE (answer="Mache ich öfters / kann ich meisten") AND assessment_id = ?',
        arguments: <dynamic>[assessmentId],
        mapper: (Map<String, dynamic> row) => Answer(
            row['id'] as int,
            row['answer'] as String,
            row['question_number'] as String,
            row['assessment_id'] as int));
  }

  @override
  Future<List<Assessment>> getAllAssessments() async {
    return _queryAdapter.queryList('SELECT * FROM Assessment',
        mapper: (Map<String, dynamic> row) => Assessment(
            row['id'] as int,
            row['project_title'] as String,
            row['overall_mood'] as String,
            row['date_created'] as String,
            row['date_finished'] as String));
  }

  @override
  Future<Assessment> findAssessment(int id) async {
    return _queryAdapter.query('SELECT * FROM Assessment WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Assessment(
            row['id'] as int,
            row['project_title'] as String,
            row['overall_mood'] as String,
            row['date_created'] as String,
            row['date_finished'] as String));
  }

  @override
  Future<Assessment> getProjectTitle(int id) async {
    return _queryAdapter.query(
        'SELECT project_title FROM Assessment WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Assessment(
            row['id'] as int,
            row['project_title'] as String,
            row['overall_mood'] as String,
            row['date_created'] as String,
            row['date_finished'] as String));
  }

  @override
  Future<List<Experience>> getAllExperiences() async {
    return _queryAdapter.queryList('SELECT * FROM Experience',
        mapper: (Map<String, dynamic> row) => Experience(
            row['id'] as int,
            row['mood'] as String,
            row['description'] as String,
            row['explanation'] as String,
            row['date_created'] as String,
            row['assessment_id'] as int));
  }

  @override
  Future<List<Experience>> getExperiencesByAssessment(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Experience WHERE assessment_id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Experience(
            row['id'] as int,
            row['mood'] as String,
            row['description'] as String,
            row['explanation'] as String,
            row['date_created'] as String,
            row['assessment_id'] as int));
  }

  @override
  Future<Experience> findExperience(int id) async {
    return _queryAdapter.query('SELECT * FROM Experience WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Experience(
            row['id'] as int,
            row['mood'] as String,
            row['description'] as String,
            row['explanation'] as String,
            row['date_created'] as String,
            row['assessment_id'] as int));
  }

  @override
  Future<List<Experience>> getPositiveExperiences(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Experience WHERE (mood = "verygreat" OR mood = "great") AND assessment_id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Experience(
            row['id'] as int,
            row['mood'] as String,
            row['description'] as String,
            row['explanation'] as String,
            row['date_created'] as String,
            row['assessment_id'] as int));
  }

  @override
  Future<List<Experience>> getNegativeExperiences(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Experience WHERE (mood = "verybad" OR mood = "bad") AND assessment_id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Experience(
            row['id'] as int,
            row['mood'] as String,
            row['description'] as String,
            row['explanation'] as String,
            row['date_created'] as String,
            row['assessment_id'] as int));
  }

  @override
  Future<List<Visualization>> getAllVisualizations() async {
    return _queryAdapter.queryList('SELECT * FROM Visualization',
        mapper: (Map<String, dynamic> row) => Visualization(
            row['id'] as int,
            row['assessment_id'] as int,
            row['noLifeAreas'] as int,
            row['lifeAreas'] as String));
  }

  @override
  Future<Visualization> findVisualization(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM Visualization WHERE assessment_id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Visualization(
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
            row['visualization_id'] as int,
            row['assessment_id'] as int));
  }

  @override
  Future<List<Person>> getAllPersonsByVisualization(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Person WHERE Visualization_id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Person(
            row['id'] as int,
            row['name'] as String,
            row['icon'] as String,
            row['lifeArea'] as String,
            row['distance'] as double,
            row['visualization_id'] as int,
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
            row['visualization_id'] as int,
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
  Future<int> createExperience(Experience experience) {
    return _experienceInsertionAdapter.insertAndReturnId(
        experience, OnConflictStrategy.abort);
  }

  @override
  Future<int> createVisualization(Visualization visualization) {
    return _visualizationInsertionAdapter.insertAndReturnId(
        visualization, OnConflictStrategy.abort);
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
  Future<int> updateExperience(Experience experience) {
    return _experienceUpdateAdapter.updateAndReturnChangedRows(
        experience, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateVisualization(Visualization visualization) {
    return _visualizationUpdateAdapter.updateAndReturnChangedRows(
        visualization, OnConflictStrategy.abort);
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
  Future<int> deleteExperience(Experience experience) {
    return _experienceDeletionAdapter.deleteAndReturnChangedRows(experience);
  }

  @override
  Future<int> deleteVisualization(Visualization visualization) {
    return _visualizationDeletionAdapter
        .deleteAndReturnChangedRows(visualization);
  }

  @override
  Future<int> deletePerson(Person person) {
    return _personDeletionAdapter.deleteAndReturnChangedRows(person);
  }
}
