import 'dart:async';

import 'package:floor/floor.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/answer.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/assessment.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/changeproject.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/networkcard.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/note.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/person.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/question.dart';


//these repository contains all DAOs for this assessment
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

  //get weakest survery answers
  @Query('SELECT * FROM Answer WHERE (answer="Kriege ich hin und wieder hin" OR answer="Schaffe ich selten") AND assessment_id = :assessmentId')
  Future<List<Answer>> getSurveyAnswers(int assessmentId);




  /* ASSESSMENT */

  //get all assessments
  @Query('SELECT * FROM Assessment')
  Future<List<Assessment>> getAllAssessments();

  //find assessment by id
  @Query('SELECT * FROM Assessment WHERE id = :id')
  Future<Assessment> findAssessment(int id);

  //new assessment
  @insert
  Future<int> createAssessment(Assessment assessment);

  //update assessment
  @update
  Future<int> updateAssessment(Assessment assessment);

  //delete assessment
  @delete
  Future<int> deleteAssessment(Assessment assessment);




  /* CHANGE PROJECT */

  //get all change projects
  @Query('SELECT * FROM ChangeProject')
  Future<List<ChangeProject>> getAllChangeProjects();

  //find changeproject by assessment_id
  @Query('SELECT * FROM ChangeProject WHERE assessment_id = :id')
  Future<ChangeProject> findChangeProject(int id);

  //new changeproject
  @insert
  Future<int> createChangeProject(ChangeProject changeProject);

  //update changeproject
  @update
  Future<int> updateChangeProject(ChangeProject changeProject);

  //delete changeproject
  @delete
  Future<int> deleteChangeProject(ChangeProject changeProject);




  /* NOTE */

  //get all notes
  @Query('SELECT * FROM Note')
  Future<List<Note>> getAllNotes();

  //get all notes by project_id and assessment_id
  @Query('SELECT * FROM Note WHERE project_id = :pid AND assessment_id = :aid')
  Future<List<Note>> getAllNotesByAssessment(int pid, int aid);

  //get specific note by note_id
  @Query('SELECT * FROM Note WHERE id = :id')
  Future<Note> findNote(int id);

  //create new note
  @insert
  Future<int> createNote(Note note);

  //update note
  @update
  Future<int> updateNote(Note note);

  //delete note
  @delete
  Future<int> deleteNote(Note note);




  /* NETWORK CARD */

  //get all network cards
  @Query('SELECT * FROM NetworkCard')
  Future<List<NetworkCard>> getAllNetworkCards();

  //get network card by assessment id
  @Query('SELECT * FROM NetworkCard WHERE assessment_id = :id')
  Future<NetworkCard> findNetworkCard(int id);


  //create new network card
  @insert
  Future<int> createNetworkCard(NetworkCard networkCard);


  //update network card
  @update
  Future<int> updateNetworkCard(NetworkCard networkCard);

  //delete network card
  @delete
  Future<int> deleteNetworkCard(NetworkCard networkCard);




  /* PERSON */

  //get all persons
  @Query('SELECT * FROM Person')
  Future<List<Person>> getAllPersons();

  //get all persons by network card
  @Query('SELECT * FROM Person WHERE network_id = :id')
  Future<List<Person>> getAllPersonsByNetworkCard(int id);

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