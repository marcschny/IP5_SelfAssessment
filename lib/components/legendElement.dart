
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';

class LegendElement extends StatelessWidget{

  final int sector;
  final String sectorName;

  const LegendElement({
    Key key,
    this.sector,
    this.sectorName
  });

  Color _getColor(){
    switch(sector){
      case 1:
        return ThemeColors.firstColor;
        break;
      case 2:
        return ThemeColors.secondColor;
        break;
      case 3:
        return ThemeColors.thirdColor;
        break;
      case 4:
        return ThemeColors.fourthColor;
        break;
      case 5:
        return ThemeColors.fifthColor;
        break;
      case 6:
        return ThemeColors.sixthColor;
        break;
      default:
        return ThemeColors.greyShade1;
        break;
    }
  }

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
                color: _getColor(),
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