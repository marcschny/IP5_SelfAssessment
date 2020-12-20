import 'dart:async';

import 'package:floor/floor.dart';
import 'package:ip5_selbsteinschaetzung/services/assessment_repository.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'entities/answer.dart';
import 'entities/person.dart';
import 'entities/question.dart';
import 'entities/assessment.dart';
import 'entities/experience.dart';
import 'entities/visualization.dart';


// generate code with following command: flutter packages pub run build_runner build
part 'database.g.dart';

@Database(
    version: 1,
    entities: [Assessment, Answer, Question, Visualization, Person, Experience])
abstract class AppDatabase extends FloorDatabase{
  AssessmentRepository get assessmentRepository;
}