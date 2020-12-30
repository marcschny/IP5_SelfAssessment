
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';
import 'package:ip5_selbsteinschaetzung/resources/visualizationMethods.dart';

class LegendElement extends StatelessWidget{

  final int sector;
  final String sectorName;

  const LegendElement({
    Key key,
    this.sector,
    this.sectorName
  });



  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: EdgeInsets.only(right: 10, bottom: 9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: TextDirection.ltr,
        children: [
          Center(
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getColor(sector),
              ),
            ),
          ),

          SizedBox(width: 6),
          Expanded(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                sectorName,
                style: ThemeTexts.toastText.copyWith(color: Colors.black26),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );
  }
}