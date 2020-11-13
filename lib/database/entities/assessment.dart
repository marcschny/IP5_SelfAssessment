//entity Person

import 'package:floor/floor.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/networdcard.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/question.dart';

import 'answer.dart';
import 'changeproject.dart';

@entity
class Assessment{
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String date_created;
  final String date_finished;

  Assessment(this.id, this.date_created, this.date_finished,);
}