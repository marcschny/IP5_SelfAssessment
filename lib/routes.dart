import 'package:flutter/cupertino.dart';
import 'package:ip5_selbsteinschaetzung/components/dialogs/person_dialog.dart';
import 'package:ip5_selbsteinschaetzung/screens/part_1/areas.dart';
import 'package:ip5_selbsteinschaetzung/screens/part_1/important_persons.dart';
import 'package:ip5_selbsteinschaetzung/screens/part_1/my_visualization.dart';
import 'package:ip5_selbsteinschaetzung/screens/part_2/improvements.dart';
import 'package:ip5_selbsteinschaetzung/screens/part_2/name_it.dart';
import 'package:ip5_selbsteinschaetzung/screens/part_2/strengths.dart';
import 'package:ip5_selbsteinschaetzung/screens/part_2/weaknesses.dart';
import 'package:ip5_selbsteinschaetzung/screens/part_2/who_can_help.dart';
import 'package:ip5_selbsteinschaetzung/screens/part_3/survey_evaluation.dart';
import 'package:ip5_selbsteinschaetzung/screens/part_3/survey_intro.dart';
import 'package:ip5_selbsteinschaetzung/screens/part_3/survey_part_1.dart';
import 'package:ip5_selbsteinschaetzung/screens/part_3/survey_part_2.dart';
import 'package:ip5_selbsteinschaetzung/screens/part_3/survey_part_3.dart';
import 'package:ip5_selbsteinschaetzung/screens/part_4/change_project.dart';
import 'package:ip5_selbsteinschaetzung/screens/part_5/congratulations.dart';
import 'package:ip5_selbsteinschaetzung/screens/part_5/evaluation.dart';
import 'package:ip5_selbsteinschaetzung/screens/part_5/my_experiences.dart';
import 'package:ip5_selbsteinschaetzung/screens/start.dart';


//this map contains all routes for this assessment
final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/start": (context) => Start(),
  "/lifeAreas": (context) => Areas(),
  "/importantPersons": (context) => ImportantPersons(),
  "/personDialog": (context) => PersonDialog(),
  "/visualization": (context) => MyVisualization(),
  "/strengths": (context) => Strengths(),
  "/weaknesses": (context) => Weaknesses(),
  "/improvements": (context) => Improvements(),
  "/nameIt": (context) => NameIt(),
  "/WhoCanHelp": (context) => WhoCanHelp(),
  "/SurveyPart1": (context) => SurveyIntro(),
  "/SurveyPart2": (context) => SurveyPart1(),
  "/SurveyPart3": (context) => SurveyPart2(),
  "/SurveyPart4": (context) => SurveyPart3(),
  "/SurveyPart5": (context) => SurveyEvaluation(),
  "/changeProject": (context) => ChangeProject(),
  "/congratulations": (context) => Congratulations(),
  "/evaluation": (context) => Evaluation(),
  "/experience": (context) => MyExperiences(),
};