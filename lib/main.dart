import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/database/creation_data_script.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/update_data_script.dart';
import 'package:ip5_selbsteinschaetzung/resources/animations/slide_up_toast.dart';
import 'package:ip5_selbsteinschaetzung/screens/change_project.dart';
import 'package:ip5_selbsteinschaetzung/screens/congratulations.dart';
import 'package:ip5_selbsteinschaetzung/screens/my_experiences.dart';
import 'package:ip5_selbsteinschaetzung/screens/strengths.dart';
import 'package:ip5_selbsteinschaetzung/screens/weaknesses.dart';
import 'package:ip5_selbsteinschaetzung/screens/improvements.dart';
import 'package:ip5_selbsteinschaetzung/screens/name_it.dart';
import 'package:ip5_selbsteinschaetzung/screens/who_can_help.dart';
import 'package:ip5_selbsteinschaetzung/screens/start.dart';
import 'package:ip5_selbsteinschaetzung/screens/areas.dart';
import 'package:ip5_selbsteinschaetzung/screens/survey_intro.dart';
import 'package:ip5_selbsteinschaetzung/screens/survey_part_1.dart';
import 'package:ip5_selbsteinschaetzung/screens/survey_part_2.dart';
import 'package:ip5_selbsteinschaetzung/screens/survey_part_3.dart';
import 'package:ip5_selbsteinschaetzung/screens/survey_evaluation.dart';
import 'package:ip5_selbsteinschaetzung/screens/my_visualization.dart';
import 'package:ip5_selbsteinschaetzung/screens/evaluation.dart';
import 'package:ip5_selbsteinschaetzung/screens/test_screen.dart';
import 'package:ip5_selbsteinschaetzung/screens/important_persons.dart';
import 'package:ip5_selbsteinschaetzung/themes/assessment_theme.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter/services.dart';
import 'components/dialogs/person_dialog.dart';


//todo: adjust all wordings
//todo: comments
//todo: code cleanup
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final callback = Callback(
      //when initialized for the first time: create questions
      onCreate: (database, version) async {
    const initScript = creationDataScript;
    for (final script in initScript) {
      await database.execute(script);
    }
  },
      //when app is opened: update questions
      onOpen: (database) async {
        const initScript = updateDataScript;
        for (final script in initScript) {
          await database.execute(script);
        }
  });

  final database = await $FloorAppDatabase
      .databaseBuilder('database.db')
      .addCallback(callback)
      .build();

  runApp(MyApp(database));
}

class MyApp extends StatelessWidget {
  const MyApp(this.database);

  final AppDatabase database;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    // the provider provides access to the app database
    return Provider<AppDatabase>(
      create: (context) => database,
      dispose: (context, db) => db.close(),
      child: OKToast(
        backgroundColor: Color.fromRGBO(140, 140, 140, .85),
        radius: 12,
        duration: Duration(seconds: 3),
        animationCurve: Curves.ease,
        animationBuilder: SlideUpToast(),
        textPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        textStyle: ThemeTexts.toastText,
        textAlign: TextAlign.center,
        position: ToastPosition.bottom,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: "/start",
          routes: {
            "/start": (context) => Start(),
            "/lifeAreas": (context) => LifeAreas(),
            "/importantPersons": (context) => ImportantPersons(),
            "/personDialog": (context) => PersonDialog(),
            "/visualization": (context) => MyVisualization(),
            "/strengths": (context) => Strengths(),
            "/weaknesses": (context) => Weaknesses(),
            "/improvements": (context) => Improvements(),
            "/nameIt": (context) => NameIt(),
            "/WhoCanHelp": (context) => WhoCanHelp(),
            "/SurveyPart1": (context) => SurveyIntro(),
            "/SurveyPart2": (context) => SurveyPart1(),
            "/SurveyPart3": (context) => SurveyPart2(),
            "/SurveyPart4": (context) => SurveyPart3(),
            "/SurveyPart5": (context) => SurveyEvaluation(),
            "/changeProject": (context) => ChangeProject(),
            "/congratulations": (context) => Congratulations(),
            "/evaluation": (context) => Evaluation(),
            "/experience": (context) => MyExperiences(),
            "/test": (context) => TestScreen(),
          },
        ),
      ),
    );
  }


}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
            "Hello World",
            style: TextStyle(fontSize: 20, color: ThemeColors.greenShade1),
          ),
      ),
    );
  }
}
