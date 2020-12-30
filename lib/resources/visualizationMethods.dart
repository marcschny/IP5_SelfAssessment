import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';

/*
 Here all all necessary methods used to build the visualization
*/

//computations methods for positioning the person circles
double computeXPosition(int distance, double angle, double centerX, double radius){
  if((distance >= 0 && distance <= 10) && (angle >= 0 && angle <= 360)) return centerX + ((radius/10)*distance) * cos(toRadian(angle));
  else return 0;
}

double computeYPosition(int distance, double angle, double centerY, double radius){
  if((distance >= 0 && distance <= 10) && (angle >= 0 && angle <= 360)) return centerY + ((radius/10)*distance) * sin(toRadian(angle));
  else return 0;
}

//convert degree to radian
double toRadian(double angle){
  return angle >= 0 && angle <= 360 ? angle * (pi / 180) : 0;
}

//get the starting angle point from sector
double getStartSectorAngle(int sector, int noLifeAreas){
  if(noLifeAreas == 2){
    switch(sector){
      case 1:
        return 180;
        break;
      case 2:
        return 0;
        break;
    }
  }else if(noLifeAreas == 3){
    switch(sector){
      case 1:
        return 240;
        break;
      case 2:
        return 120;
        break;
      case 3:
        return 0;
        break;
    }
  }else if(noLifeAreas == 4){
    switch(sector){
      case 1:
        return 90;
        break;
      case 2:
        return 0;
        break;
      case 3:
        return 270;
        break;
      case 4:
        return 180;
        break;
    }
  }else if(noLifeAreas == 5){
    switch(sector){
      case 1:
        return 0;
        break;
      case 2:
        return 288;
        break;
      case 3:
        return 216;
        break;
      case 4:
        return 144;
        break;
      case 5:
        return 72;
        break;
    }
  }else if(noLifeAreas == 6){
    switch(sector){
      case 1:
        return 300;
        break;
      case 2:
        return 240;
        break;
      case 3:
        return 180;
        break;
      case 4:
        return 120;
        break;
      case 5:
        return 60;
        break;
      case 6:
        return 0;
        break;
    }
  }else{
    return 0;
  }
}

Color getColor(sector){
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

