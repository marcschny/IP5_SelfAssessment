import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/person.dart';
import 'package:ip5_selbsteinschaetzung/themes/assessment_theme.dart';


//this is the important person tile used in important_persons (part_1)
class ImportantPersonTile extends StatelessWidget{

  final Person person;

  const ImportantPersonTile({
    Key key,
    this.person
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: TextDirection.ltr,
        children: [
          Container(
            child: Center(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Icon(
                  //todo: update with category icons from person.icon
                  Icons.person,
                  size: 40,
                  color: Color.fromRGBO(80, 80, 80, 1),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.ltr,
              children: [
                Expanded(
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      person.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: ThemeTexts.assessmentSubquestion.copyWith(fontWeight: FontWeight.w600),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Expanded(
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      person.lifeArea,
                      style: ThemeTexts.assessmentNavigationNext.copyWith(color: Color.fromRGBO(149, 149, 140, 1)),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}