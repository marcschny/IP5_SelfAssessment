//entity Person

import 'package:floor/floor.dart';

import 'assessment.dart';

@Entity(
  tableName: 'ProjectCard',
  foreignKeys: [
    ForeignKey(
      childColumns: ['assessment_id'],
      parentColumns: ['id'],
      entity: Assessment,
    )
  ],
)
class ProjectCard{
  @PrimaryKey(autoGenerate: true)
  final int id;
  final int mood;
  final String description;
  final String explanation;
  final String date_created;
  final int assessment_id;

  ProjectCard(this.id, this.mood, this.description, this.explanation,this.date_created, this.assessment_id);
}