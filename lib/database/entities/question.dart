//entity Person

import 'package:floor/floor.dart';

import 'assessment.dart';

@Entity(
  tableName: 'Question',
  primaryKeys: ['id', 'question_number'],
  foreignKeys: [
    ForeignKey(
      childColumns: ['assessment_id'],
      parentColumns: ['id'],
      entity: Assessment,
    )
  ],
)
class Question{
  final int id;
  final String question_number;
  final bool answered;
  final String question;
  final String subquestion;
  final int assessment_id;

  Question(this.id, this.question_number, this.answered, this.question, this.subquestion, this.assessment_id);
}