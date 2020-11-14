//entity Person

import 'package:floor/floor.dart';


@entity
class Assessment{
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String date_created;
  final String date_finished;

  Assessment(this.id, this.date_created, this.date_finished,);
}