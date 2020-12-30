import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ip5_selbsteinschaetzung/components/CheckBoxComponent.dart';
import 'package:ip5_selbsteinschaetzung/components/nextButton.dart';
import 'package:ip5_selbsteinschaetzung/components/experienceCard.dart';
import 'package:ip5_selbsteinschaetzung/components/importantPersonTile.dart';
import 'package:ip5_selbsteinschaetzung/components/legendElement.dart';
import 'package:ip5_selbsteinschaetzung/components/notEditableExperienceDialog.dart';
import 'package:ip5_selbsteinschaetzung/components/personCircle.dart';
import 'package:ip5_selbsteinschaetzung/components/progressBar.dart';
import 'package:ip5_selbsteinschaetzung/components/surveyBox.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/experience.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/person.dart';
import 'package:ip5_selbsteinschaetzung/screens/SurveyPart1.dart';
import 'package:test/test.dart' as test;


void main(){

  //helper method to setup widgets which need a MaterialApp to be built
  Widget buildTestableWidget(Widget widget){
    return MaterialApp(home: Scaffold(body: widget));
  }



  //testWidgets
  test.group('ui tests for custom components', (){

    testWidgets('TopBar Widget Test', (WidgetTester tester) async{
      await tester.pumpWidget(buildTestableWidget(TopBar(title: "Testtitle", titleNumber: 2, subtitle: "Testsubtitle", percent: 0.1, showProgressbar: true)));

      expect(find.text("Testtitle"), findsOneWidget);
      expect(find.text("Testsubtitle"), findsOneWidget);
      expect(find.text("2"), findsOneWidget);
      expect(find.byType(ProgressBar), findsOneWidget);
    });

    testWidgets('NextButton Widget Test', (WidgetTester tester) async{
      await tester.pumpWidget(buildTestableWidget(NextButton(nextTitle: "Next Title", callback: null)));

      expect(find.text("Next Title"), findsOneWidget);
      expect(find.byType(Wrap), findsOneWidget);
    });

    testWidgets('SurveyBox Widget Test', (WidgetTester tester) async{
      await tester.pumpWidget(buildTestableWidget(SurveyBox(question: "Some question", checked: false)));

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
      final personAreaFinder = find.text("Testlifearea");

      expect(personNameFinder, findsOneWidget);
      expect(personAreaFinder, findsOneWidget);
    });


    testWidgets('ExperienceCard Widget Test', (WidgetTester tester) async{
      final Experience experience = Experience(1, "great", "My first experience", "explanation", DateTime.now().toString(), 1);
      await tester.pumpWidget(ExperienceCard(experience: experience, editable: false));

      final experienceTextFinder = find.text("My first experience");

      expect(experienceTextFinder, findsOneWidget);
    });


  });

  test.group('test screens and interactivity', (){

    testWidgets('Survey Part 1', (WidgetTester tester) async {

      await tester.pumpWidget(buildTestableWidget(SurveyPart1()));

      expect(find.text("Fragebogen"), findsOneWidget);
      expect(find.byType(RaisedButton), findsOneWidget);

      await tester.tap(find.byType(RaisedButton));


    });

    testWidgets('NotEditableExperience Dialog with no explanation', (WidgetTester tester) async {

      Experience experience = new Experience(1, "great", "Lorem ipsum", null, "2020-03-12", 1);
      await tester.pumpWidget(buildTestableWidget(NotEditableExperienceDialog(experience: experience)));

      expect(find.text("Lorem ipsum"), findsOneWidget);
      expect(find.text("Keine Erläuterung dazu vorhanden..."), findsOneWidget);
      expect(find.byType(RaisedButton), findsOneWidget);

      await tester.pump(Duration(milliseconds: 2000));

    });

  });












}