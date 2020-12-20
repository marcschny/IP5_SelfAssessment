//entity Person

import 'package:floor/floor.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/assessment.dart';

@Entity(
  tableName: 'Visualization',
  foreignKeys: [
    ForeignKey(
      childColumns: ['assessment_id'],
      parentColumns: ['id'],
      entity: Assessment,
    )
  ],
)
class Visualization{
  @PrimaryKey(autoGenerate: true)
  final int id;
  final int noLifeAreas;
  final String lifeAreas;
  final int assessment_id;

  Visualization(this.id, this.assessment_id, this.noLifeAreas, this.lifeAreas);
}