//entity Person

import 'package:floor/floor.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/assessment.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/visualization.dart';

@Entity(
  tableName: 'Person',
  foreignKeys: [
    ForeignKey(
      childColumns: ['visualization_id'],
      parentColumns: ['id'],
      entity: Visualization,
    ),
    ForeignKey(
      childColumns: ['assessment_id'],
      parentColumns: ['id'],
      entity: Assessment,
    ),
  ],
)
class Person{
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String name;
  final String icon;
  final String lifeArea;
  final double distance;
  final int visualization_id;
  final int assessment_id;

  Person(this.id, this.name, this.icon, this.lifeArea, this.distance, this.visualization_id, this.assessment_id);
}