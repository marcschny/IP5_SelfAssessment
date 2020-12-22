import 'package:flutter_test/flutter_test.dart';
import 'package:floor/floor.dart';
import 'package:ip5_selbsteinschaetzung/database/database_initial_data.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/answer.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/question.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/visualization.dart';
import 'package:matcher/matcher.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/assessment.dart';
import 'package:ip5_selbsteinschaetzung/services/assessment_repository.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/person.dart';


void main() {

  group('database tests', () {
    AppDatabase database;
    AssessmentRepository repository;

    setUp(() async {

      final callback = Callback(
          onCreate: (database, version) async {
            const initScript = initialDataScript;
            for (final script in initScript) {
              await database.execute(script);
            }
      });

      database = await $FloorAppDatabase
          .inMemoryDatabaseBuilder()
          .addCallback(callback)
          .build();
      repository = database.assessmentRepository;
      final Assessment assessment = Assessment(1, "", "", "28-11-2020", "29-11-2020");
      final Visualization visualization = Visualization(1, 1, 5, "lifeAreas");
      repository
        ..createAssessment(assessment)
        ..createVisualization(visualization);
    });

    tearDown(() async {
      await database.close();
    });

    group('person tests', (){

      test('add a person', () async {
        final person = Person(null, "Thomas", "thomasIcon", "thomasArea", 5, 1, 1);
        await repository.createPerson(person);

        final actual = await repository.getAllPersons();

        expect(actual, hasLength(1));
      });


      test('find person by id', () async {
        final person = Person(1, "Alex", "alexIcon", "alexArea", 5, 1, 1);
        await repository.createPerson(person);

        final actualPerson = await repository.findPerson(person.id);

        expect(actualPerson.id, person.id);
      });

      test('update person', () async{
        final person = Person(2, "Michael", "michaelIcon", "michaelArea", 5, 1, 1);
        await repository.createPerson(person);
        final updatePerson = Person(person.id, "Angelo", person.icon, person.lifeArea, person.distance, person.visualization_id, person.assessment_id);

        await repository.updatePerson(updatePerson);

        final actualPerson = await repository.findPerson(person.id);
        expect(actualPerson.name, updatePerson.name);

      });


      test('delete person', () async{
        final person = Person(3, "Peter", "peterIcon", "peterArea", 5, 1, 1);
        await repository.createPerson(person);

        await repository.deletePerson(person);

        final actual = await repository.getAllPersons();
        expect(actual, isEmpty);

      });

    });

    group('question tests', (){

      test('get question by question_number and assessment_id', () async{
        final question = Question(1, '3.2.1', 'Ein Gespräch anfangen/andere ansprechen', '', 1);
        final actual = await repository.findQuestion(question.question_number);

        expect(actual.question, question.question);
      });

    });

    group('answer tests', (){

      test('find answer by question_number and assessment_id', () async{
        final answer = Answer(1, "my answer", "2.2.1", 1);
        await repository.insertAnswer(answer);

        final actual = await repository.findAnswer(answer.question_number, answer.assessment_id);
        expect(actual.id, answer.id);
      });

      test('get answer', () async{
        final answer = Answer(null, "my answer", "2.2.1", 1);
        await repository.insertAnswer(answer);

        final actual = await repository.getAllAnswersByAssessment(answer.assessment_id);
        expect(actual, hasLength(1));
      });

      test('get added answers by assessment_id', () async{
        final answer1 = Answer(null, "my answer 1", "2.2.1", 1);
        final answer2 = Answer(null, "my answer 2", "2.2.2", 1);
        final answer3 = Answer(null, "my answer 3", "2.2.3", 1);
        await repository
          ..insertAnswer(answer1)
          ..insertAnswer(answer2)
          ..insertAnswer(answer3);

        final actual = await repository.getAllAnswersByAssessment(answer1.assessment_id);
        expect(actual, hasLength(3));
      });

      test('update answer', () async{
        final answer = Answer(2, "my answer", "2.2.1", 1);
        await repository.insertAnswer(answer);

        final updateAnswer = Answer(answer.id, "new answer", answer.question_number, answer.assessment_id);
        await repository.updateAnswer(updateAnswer);

        final actual = await repository.findAnswer(answer.question_number, answer.assessment_id);
        expect(actual.answer, updateAnswer.answer);
      });

      test('delete answer', () async{
        final answer = Answer(3, "my answer", "2.2.1", 1);
        await repository.insertAnswer(answer);

        await repository.deleteAnswer(answer);

        final actual = await repository.getAllAnswersByAssessment(answer.assessment_id);
        expect(actual, isEmpty);
      });


    });

    group('visualization tests', (){

      test('update visualization', () async{

        final updateVisualization = Visualization(1, 1, 4, "updated life areas");
        await repository.updateVisualization(updateVisualization);

        final actual = await repository.findVisualization(1);
        expect(actual.noLifeAreas, updateVisualization.noLifeAreas);
        expect(actual.lifeAreas, updateVisualization.lifeAreas);
      });

      test('create Visualization', () async{
        //one visualization has been created in setup()
        final actual = await repository.getAllVisualizations();
        expect(actual, hasLength(1));
      });

      test('delete Visualization', () async{
        //one visualization has been created in setup()
        final visualization = Visualization(2, 1, 5, "lifeAreas");
        await repository.createVisualization(visualization);

        await repository.deleteVisualization(visualization);

        final actual = await repository.getAllVisualizations();
        expect(actual, hasLength(1));
      });

    });
    
    
  });
}