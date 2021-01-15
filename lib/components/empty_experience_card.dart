import 'package:flutter/cupertino.dart';

//this is the component for an empty experience card used in change_project (part_4)
class EmptyExperienceCard extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: Color.fromRGBO(237, 237, 237, 1),
          width: 110,
        ),
      ),
    );
  }


}