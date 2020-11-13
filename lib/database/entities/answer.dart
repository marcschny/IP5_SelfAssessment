//entity Person

import 'package:floor/floor.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/question.dart';

@Entity(
  tableName: 'Answer',
  foreignKeys: [
    ForeignKey(
      childColumns: ['question_number'],
      parentColumns: ['question_number'],
      entity: Question,
    )
  ],
)
class Answer{
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String answer;
  final String question_number;

  Answer(this.id, this.answer, this.question_number);
}