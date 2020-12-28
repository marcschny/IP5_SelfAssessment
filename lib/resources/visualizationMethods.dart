import 'dart:math';

/*
 Here all all necessary methods used to build the visualization
*/

//computations methods for positioning the person circles
double computeXPosition(int distance, double angle, double centerX, double radius){
  return centerX + ((radius/10)*distance) * cos(toRadian(angle));
}

double computeYPosition(int distance, double angle, double centerY, double radius){
  return centerY + ((radius/10)*distance) * sin(toRadian(angle));
}

//convert degree to radian
double toRadian(double angle){
  return angle * (pi / 180);
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
    return -1000;
  }
}

