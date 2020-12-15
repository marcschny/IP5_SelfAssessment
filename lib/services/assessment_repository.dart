import 'dart:async';

import 'package:floor/floor.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/answer.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/assessment.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/projectcard.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/person.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/question.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/visualization.dart';


//this repository contains all DAOs for this assessment
@dao
abstract class AssessmentRepository{


  /* QUESTION */

  //get all questions
  @Query('SELECT * FROM Question')
  Future<List<Question>> getAllQuestions();

  //get all questions by assessment_id
  @Query('SELECT * FROM Question WHERE assessment_id = :assessment_id')
  Future<List<Question>> getAllQuestionsByAssessment(int assessment_id);

  //find specific question by question_number
  @Query('SELECT * FROM Question WHERE question_number = :question_number')
  Future<Question> findQuestion(String question_number);

  //update question
  @update
  Future<int> updateQuestion(Question question);

  //questions are currently added and modified from 'database_initial_data' script




  /* ANSWER */

  //find answer by question_number and assessment_id
  @Query('SELECT * FROM Answer WHERE question_number = :question_number AND assessment_id = :assessmentId') //AND assessment_id = :assessment_id
  Future<Answer> findAnswer(String question_number, int assessmentId); //, int assessment_id

  //get all answers by assessment_id
  @Query('SELECT * FROM Answer WHERE assessment_id = :assessment_id')
  Future<List<Answer>> getAllAnswersByAssessment(int assessment_id);

  //insert answer
  @insert
  Future<int> insertAnswer(Answer answer);

  //update answer
  @update
  Future<int> updateAnswer(Answer answer);

  //delete answer
  @delete
  Future<int> deleteAnswer(Answer answer);



  /* SURVEY ANSWERS */

  //get negative survey answers
  @Query('SELECT * FROM Answer WHERE (answer="Kriege ich hin und wieder hin" OR answer="Schaffe ich selten") AND assessment_id = :assessmentId')
  Future<List<Answer>> getNegSurveyAnswers(int assessmentId);

  //get positive survey answers
  @Query('SELECT * FROM Answer WHERE (answer="Mache ich öfters / kann ich meisten") AND assessment_id = :assessmentId')
  Future<List<Answer>> getPosSurveyAnswers(int assessmentId);




  /* ASSESSMENT */

  //get all assessments
  @Query('SELECT * FROM Assessment')
  Future<List<Assessment>> getAllAssessments();

  //find assessment by id
  @Query('SELECT * FROM Assessment WHERE id = :id')
  Future<Assessment> findAssessment(int id);

  //get project title
  @Query('SELECT project_title FROM Assessment WHERE id = :id')
  Future<Assessment> getProjectTitle(int id);

  //new assessment
  @insert
  Future<int> createAssessment(Assessment assessment);

  //update assessment
  @update
  Future<int> updateAssessment(Assessment assessment);

  //delete assessment
  @delete
  Future<int> deleteAssessment(Assessment assessment);




  /* PROJECT CARD */

  //get all project cards
  @Query('SELECT * FROM ProjectCard')
  Future<List<ProjectCard>> getAllProjectCards();

  //get projectcard by assessment_id
  @Query('SELECT * FROM ProjectCard WHERE assessment_id = :id')
  Future<List<ProjectCard>> getProjectCardsByAssessment(int id);

  //find specific projectcard by id
  @Query('SELECT * FROM ProjectCard WHERE id = :id')
  Future<ProjectCard> findProjectCard(int id);

  //new ProjectCard
  @insert
  Future<int> createProjectCard(ProjectCard projectCard);

  //update ProjectCard
  @update
  Future<int> updateProjectCard(ProjectCard projectCard);


  //delete ProjectCard
  @delete
  Future<int> deleteProjectCard(ProjectCard projectCard);




  /* VISUALIZATION*/

  //get all visualizations
  @Query('SELECT * FROM Visualization')
  Future<List<Visualization>> getAllVisualizations();

  //get visualization by assessment id
  @Query('SELECT * FROM Visualization WHERE assessment_id = :id')
  Future<Visualization> findVisualization(int id);

  //create new visualization
  @insert
  Future<int> createVisualization(Visualization visualization);

  //update visualization
  @update
  Future<int> updateVisualization(Visualization visualization);

  //delete visualization
  @delete
  Future<int> deleteVisualization(Visualization visualization);




  /* PERSON */

  //get all persons
  @Query('SELECT * FROM Person')
  Future<List<Person>> getAllPersons();

  //get all persons by Visualization
  @Query('SELECT * FROM Person WHERE Visualization_id = :id')
  Future<List<Person>> getAllPersonsByVisualization(int id);

  //find specific person by id
  @Query('SELECT * FROM Person WHERE id = :id')
  Future<Person> findPerson(int id);

  //create Person
  @insert
  Future<int> createPerson(Person person);

  //update Person
  @update
  Future<int> updatePerson(Person person);

  //delete Person
  @delete
  Future<int> deletePerson(Person person);



}