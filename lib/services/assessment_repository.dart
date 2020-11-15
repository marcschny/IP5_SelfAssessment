import 'dart:async';

import 'package:floor/floor.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/answer.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/assessment.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/changeproject.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/networdcard.dart';
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

  //find specific question by question_number and assessment_id
  @Query('SELECT * FROM Question WHERE question_number = :question_number AND assessment_id = :assessment_id')
  Future<List<Question>> findQuestion(String question_number, int assessment_id);

  //questions are currently added and modified from 'database_initial_data' script




  /* ANSWER */

  //find answer by question_number
  @Query('SELECT * FROM Answer WHERE question_number = :question_number AND assessment_id')
  Future<Question> findAnswer(String question_number, int assessment_id);

  //get all answers by assessment_id
  @Query('SELECT * FROM Answer WHERE assessment_id = :assessment_id')
  Future<List<Question>> getAllAnswersByAssessment(int assessment_id);

  //insert answer
  @insert
  Future<void> insertAnswer(Answer answer);

  //update answer
  @update
  Future<void> updateAnswer(Answer answer);

  //delete answer
  @delete
  Future<void> deleteAnswer(Answer answer);




  /* ASSESSMENT */

  //get all assessments
  @Query('SELECT * FROM Assessment')
  Future<List<Assessment>> getAllAssessments();

  //find assessment by id
  @Query('SELECT * FROM Assessment WHERE id = :id')
  Future<Assessment> findAssessment(int id);

  //new assessment
  @insert
  Future<void> createAssessment(Assessment assessment);

  //update assessment
  @update
  Future<void> updateAssessment(Assessment assessment);

  //delete assessment
  @delete
  Future<void> deleteAssessment(Assessment assessment);




  /* CHANGE PROJECT */

  //get all change projects
  @Query('SELECT * FROM ChangeProject')
  Future<List<ChangeProject>> getAllChangeProjects();

  //find changeproject by assessment_id
  @Query('SELECT * FROM ChangeProject WHERE assessment_id = :id')
  Future<ChangeProject> findChangeProject(int id);

  //new changeproject
  @insert
  Future<void> createChangeProject();

  //update changeproject
  @update
  Future<void> updateChangeProject();

  //delete changeproject
  @delete
  Future<void> deleteChangeProject();




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
  Future<void> createNote();

  //update note
  @update
  Future<void> updateNote();

  //delete note
  @delete
  Future<void> deleteNote();




  /* NETWORK CARD */

  //get all network cards
  @Query('SELECT * FROM NetworkCard')
  Future<List<NetworkCard>> getAllNetworkCards();

  //get network card by assessment id
  @Query('SELECT * FROM NetworkCard WHERE assessment_id = :id')
  Future<NetworkCard> findNetworkCard(int id);

  //create new network card
  @insert
  Future<void> createNetworkCard();

  //update network card
  @update
  Future<void> updateNetworkCard();

  //delete network card
  @delete
  Future<void> deleteNetworkCard();




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
  Future<void> createPerson();

  //update Person
  @update
  Future<void> updatePerson();

  //delete Person
  @delete
  Future<void> deletePerson();



}