import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ip5_selbsteinschaetzung/components/CheckBoxComponent.dart';
import 'package:ip5_selbsteinschaetzung/components/NextButton.dart';
import 'package:ip5_selbsteinschaetzung/components/experienceCard.dart';
import 'package:ip5_selbsteinschaetzung/components/importantPersonTile.dart';
import 'package:ip5_selbsteinschaetzung/components/legendElement.dart';
import 'package:ip5_selbsteinschaetzung/components/personCircle.dart';
import 'package:ip5_selbsteinschaetzung/components/progressBar.dart';
import 'package:ip5_selbsteinschaetzung/components/surveyBox.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/experience.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/person.dart';


//test with: flutter test test/widget_tests.dart
void main(){

  //setup widgets which need a MaterialApp to be built
  const MaterialApp topBar = MaterialApp(
    home: Scaffold(
      body: const TopBar(title: "Testtitle", titleNumber: 2, onClose: null, subtitle: "Testsubtitle", percent: 0.1, showProgressbar: true),
    ),
  );

  const MaterialApp nextButton = MaterialApp(
    home: Scaffold(
      body: const NextButton(nextTitle: "Next Title", callback: null)
    ),
  );

  const MaterialApp surveyBox = MaterialApp(
    home: Scaffold(
      body: const SurveyBox(question: "Some question", checked: false)
    ),
  );




  //testWidgets
  testWidgets('TopBar Widget Test', (WidgetTester tester) async{
    await tester.pumpWidget(topBar);

    expect(find.text("Testtitle"), findsOneWidget);
    expect(find.text("Testsubtitle"), findsOneWidget);
    expect(find.text("2"), findsOneWidget);
    expect(find.byType(ProgressBar), findsOneWidget);
  });

  testWidgets('NextButton Widget Test', (WidgetTester tester) async{
    await tester.pumpWidget(nextButton);

    expect(find.text("Next Title"), findsOneWidget);
    expect(find.byType(Wrap), findsOneWidget);
  });

  testWidgets('SurveyBox Widget Test', (WidgetTester tester) async{
    await tester.pumpWidget(surveyBox);

    expect(find.text("Some question"), findsOneWidget);
  });

  testWidgets('PersonCircle Widget Test', (WidgetTester tester) async{
    Person person = Person(1, "Peter", "adult", "lifeArea", 5, 1, 1);
    await tester.pumpWidget(PersonCircle(person: person));

    expect(find.byType(Icon), findsOneWidget);
  });



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


  testWidgets('ExperienceCard Widget Test', (WidgetTester tester) async{
    final Experience experience = Experience(1, "great", "My first experience", "explanation", DateTime.now().toString(), 1);
    await tester.pumpWidget(ExperienceCard(experience: experience, editable: false));

    final experienceTextFinder = find.text("My first experience");

    expect(experienceTextFinder, findsOneWidget);
  });




}