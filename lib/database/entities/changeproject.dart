//entity Person

import 'package:floor/floor.dart';

import 'assessment.dart';

@Entity(
  tableName: 'ChangeProject',
  foreignKeys: [
    ForeignKey(
      childColumns: ['assessment_id'],
      parentColumns: ['id'],
      entity: Assessment,
    )
  ],
)
class ChangeProject{
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String title;
  final String date_started;
  final String date_finished;
  final int assessment_id;

  ChangeProject(this.id, this.title, this.date_started, this.date_finished, this.assessment_id);
}