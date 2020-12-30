import 'package:flutter_test/flutter_test.dart';
import 'package:ip5_selbsteinschaetzung/components/bottom_navigation.dart';
import 'package:ip5_selbsteinschaetzung/resources/visualization_methods.dart';


void main(){

  test('BottomNavigation Unit Test', (){
    String nextTitle = "test route";

    bool executedCallbackBack = false;
    bool executedCallbackNext = false;

    final bottomNav = BottomNavigation(nextTitle: nextTitle, callbackBack: () => executedCallbackBack = true, callbackNext: () => executedCallbackNext = true);

    bottomNav.callbackBack();
    expect(executedCallbackBack, true);

    bottomNav.callbackNext();
    expect(executedCallbackNext, true);

    expect(bottomNav.nextTitle, nextTitle);

  });

  group("Unit tests for the visualization methods", (){

    test('test toRadian method', (){
      double validDegree = 160;
      double validRadian = 2.79253;
      double actual = double.parse(toRadian(validDegree).toStringAsFixed(5));
      expect(actual, validRadian);

      double invalidDegree = 400;
      double invalidRadian = 0;
      expect(toRadian(invalidDegree), invalidRadian);
    });

    test('test computeXPosition method with valid values', (){
      double centerX = 180;
      double radius = 100;

      double validAngle = 160;
      int validDistance = 5;
      double validXPosition = 133.01537;
      double actual = double.parse(computeXPosition(validDistance, validAngle, centerX, radius).toStringAsFixed(5));
      expect(actual, validXPosition);
    });

    test('test computeXPosition method with invalid values', (){
      double centerX = 180;
      double radius = 100;

      double invalidAngle = 460;
      int validDistance = 5;
      double invalidXPosition = 0;
      double actual = double.parse(computeXPosition(validDistance, invalidAngle, centerX, radius).toStringAsFixed(5));
      expect(actual, invalidXPosition);
    });

    test('test computeYPosition method with valid values', (){
      double centerY = 180;
      double radius = 100;

      double validAngle = 160;
      int validDistance = 5;
      double validYPosition = 197.10101;
      double actual = double.parse(computeYPosition(validDistance, validAngle, centerY, radius).toStringAsFixed(5));
      expect(actual, validYPosition);
    });

    test('test computeYPosition method with invalid values', (){
      double centerY = 180;
      double radius = 100;

      double validAngle = 160;
      int invalidDistance = 15;
      double invalidYPosition = 0;
      double actual = double.parse(computeYPosition(invalidDistance, validAngle, centerY, radius).toStringAsFixed(5));
      expect(actual, invalidYPosition);
    });

  });


}