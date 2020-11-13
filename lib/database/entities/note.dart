//entity Person

import 'package:floor/floor.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/changeproject.dart';

@Entity(
  tableName: 'Note',
  foreignKeys: [
    ForeignKey(
      childColumns: ['project_id'],
      parentColumns: ['id'],
      entity: ChangeProject,
    )
  ],
)
class Note{
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String note;
  final String date_created;
  final int project_id;

  Note(this.id, this.note, this.date_created, this.project_id);
}