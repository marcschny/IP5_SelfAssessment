


import 'package:flutter_test/flutter_test.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/CheckBoxComponent.dart';
import 'package:ip5_selbsteinschaetzung/components/importantPersonTile.dart';
import 'package:ip5_selbsteinschaetzung/components/legendElement.dart';
import 'package:ip5_selbsteinschaetzung/components/personCircle.dart';
import 'package:ip5_selbsteinschaetzung/components/questionDialog.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/person.dart';

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


}