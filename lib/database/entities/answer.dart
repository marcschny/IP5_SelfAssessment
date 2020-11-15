//entity Person

import 'package:floor/floor.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/assessment.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/question.dart';

@Entity(
  tableName: 'Answer',
  foreignKeys: [
    ForeignKey(
      childColumns: ['question_number'],
      parentColumns: ['question_number'],
      entity: Question,
    ),
    ForeignKey(
      childColumns: ['assessment_id'],
      parentColumns: ['id'],
      entity: Assessment,
    )
  ],
)
class Answer{
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String answer;
  final String question_number;
  final int assessment_id;

  Answer(this.id, this.answer, this.question_number, this.assessment_id);
}