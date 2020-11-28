import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:floor/floor.dart';
import 'package:matcher/matcher.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/assessment.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/networkcard.dart';

import 'package:ip5_selbsteinschaetzung/services/assessment_repository.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/person.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/networkcard.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/assessment.dart';

void main() {

  group('database tests', () {
    AppDatabase database;
    AssessmentRepository repository;

    setUp(() async {
      database = await $FloorAppDatabase
          .inMemoryDatabaseBuilder()
          .build();
      repository = database.assessmentRepository;
      final Assessment assessment = Assessment(1, "28-11-2020", "29-11-2020");
      final NetworkCard networkCard = NetworkCard(1, 1, 5, "lifeAreas");
      repository
        ..createAssessment(assessment)
        ..createNetworkCard(networkCard);
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
        final updatePerson = Person(person.id, "Angelo", person.icon, person.lifeArea, person.distance, person.network_id, person.assessment_id);

        await repository.updatePerson(updatePerson);

        final actualPerson = await repository.findPerson(person.id);
        expect(actualPerson.name, updatePerson.name);

      });


      test('delete person', () async{
        final Person person = Person(3, "Peter", "peterIcon", "peterArea", 5, 1, 1);
        await repository.createPerson(person);

        await repository.deletePerson(person);

        final actual = await repository.getAllPersons();
        expect(actual, isEmpty);

      });

    });
    
    
  });
}