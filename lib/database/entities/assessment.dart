//entity Person

import 'package:floor/floor.dart';


@entity
class Assessment{
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String project_title;
  final String date_created;
  final String date_finished;

  Assessment(this.id, this.project_title, this.date_created, this.date_finished,);
}