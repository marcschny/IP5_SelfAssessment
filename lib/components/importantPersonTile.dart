import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';

class ImportantPersonTile extends StatelessWidget{

  final int id;
  final String icon;
  final String name;
  final String lifeArea;


  const ImportantPersonTile({
    Key key,
    this.id,
    this.icon,
    this.name,
    this.lifeArea
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 60,
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: Color.fromRGBO(220, 220, 220, 1),
              width: 1
            )
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Center(
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Color.fromRGBO(80, 80, 80, 1),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: ThemeTexts.assessmentSubquestion.copyWith(fontWeight: FontWeight.w600),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      lifeArea,
                      style: ThemeTexts.assessmentNavigationNext.copyWith(color: Color.fromRGBO(149, 149, 140, 1)),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: (){
        print("tapped on: "+name);
      },
    );
  }


}