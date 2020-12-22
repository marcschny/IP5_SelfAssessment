import 'package:flutter_test/flutter_test.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/CheckBoxComponent.dart';
import 'package:ip5_selbsteinschaetzung/components/NextButton.dart';
import 'package:ip5_selbsteinschaetzung/components/importantPersonTile.dart';
import 'package:ip5_selbsteinschaetzung/components/legendElement.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/person.dart';
import 'package:ip5_selbsteinschaetzung/resources/visualizationMethods.dart';

//todo: adjust widget tests to pass
void main(){

  //test with: flutter test test/widget_tests.dart
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



  /*testWidgets('NextButton Widget Test', (WidgetTester tester) async{

    await tester.pumpWidget(NextButton(nextTitle: "nextTitle", callback: null));

    final titleFinder = find.text("nextTitle");

    expect(titleFinder, findsOneWidget);
  });*/


  testWidgets('CheckBoxComponent Widget Test', (WidgetTester tester) async{

    await tester.pumpWidget(CheckBoxComponent(checkboxTitle: "checkboxTitlte", checked: false));

    final titleFinder = find.text("checkboxTitlte");

    expect(titleFinder, findsOneWidget);
  });


  testWidgets('LegendElement Widget Test', (WidgetTester tester) async{

    await tester.pumpWidget(LegendElement(sectorName: "sectorTestname", sector: 1));

    final sectorNameFinder = find.text("sectorTestname");

    expect(sectorNameFinder, findsOneWidget);
  });


  testWidgets('ImportantPersonTile Widget Test', (WidgetTester tester) async{
    Person person = Person(1, "Testname", "Testicon", "Testlifearea", 5, 1,1 );

    await tester.pumpWidget(ImportantPersonTile(person: person));

    final personNameFinder = find.text("Testname");
    final personLifeareaFinder = find.text("Testlifearea");

    expect(personNameFinder, findsOneWidget);
    expect(personLifeareaFinder, findsOneWidget);
  });


  group("Unit tests for the visualization methods", (){

    test('test toRadian method', (){
      double validDegree = 160;
      double validRadian = 2.79253;
      double actual = double.parse(toRadian(validDegree).toStringAsFixed(5));
      expect(actual, validRadian);

      double invalidDegree = 400;
      double invalidRadian = null;
      expect(toRadian(invalidDegree), invalidRadian);
    });

    test('test computeXPosition method', (){
      double centerX = 180;
      double radius = 100;

      double validAngle = 160;
      int validDistance = 5;
      double validXPosition = 133.01537;
      double actual = double.parse(computeXPosition(validDistance, validAngle, centerX, radius).toStringAsFixed(5));
      expect(actual, validXPosition);
      

    });

    test('test computeYPosition method', (){
      double centerY = 180;
      double radius = 100;

      double validAngle = 160;
      int validDistance = 5;
      double validYPosition = 197.10101;
      double actual = double.parse(computeYPosition(validDistance, validAngle, centerY, radius).toStringAsFixed(5));
      expect(actual, validYPosition);


    });

  });


}