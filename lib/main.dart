import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/database/database_initial_data.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/screens/ChangeProject.dart';
import 'package:ip5_selbsteinschaetzung/screens/Congratulations.dart';
import 'package:ip5_selbsteinschaetzung/screens/MyExperiences.dart';
import 'package:ip5_selbsteinschaetzung/screens/Strengths.dart';
import 'package:ip5_selbsteinschaetzung/screens/Weaknesses.dart';
import 'package:ip5_selbsteinschaetzung/screens/Improvements.dart';
import 'package:ip5_selbsteinschaetzung/screens/NameIt.dart';
import 'package:ip5_selbsteinschaetzung/screens/WhoCanHelp.dart';
import 'package:ip5_selbsteinschaetzung/screens/0_Start.dart';
import 'package:ip5_selbsteinschaetzung/screens/LifeAreas.dart';
import 'package:ip5_selbsteinschaetzung/screens/SurveyPart1.dart';
import 'package:ip5_selbsteinschaetzung/screens/SurveyPart2.dart';
import 'package:ip5_selbsteinschaetzung/screens/SurveyPart3.dart';
import 'package:ip5_selbsteinschaetzung/screens/SurveyPart4.dart';
import 'package:ip5_selbsteinschaetzung/screens/SurveyPart5.dart';
import 'package:ip5_selbsteinschaetzung/screens/MyVisualization.dart';
import 'package:ip5_selbsteinschaetzung/screens/Evaluation.dart';
import 'package:ip5_selbsteinschaetzung/screens/TestScreen.dart';
import 'package:ip5_selbsteinschaetzung/screens/importantPersons.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter/services.dart';
import 'components/personDialog.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final callback = Callback(
      //when initialized for the first time
      onCreate: (database, version) async {
    const initScript = initialDataScript;
    for (final script in initScript) {
      await database.execute(script);
    }
  },
      //todo:
      //when app is opened
      onOpen: (database) async {
    //tbd
  },
      //todo:
      //when upgraded
      onUpgrade: (database, startVersion, endVersion) {
    //tbd
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
    return Provider<AppDatabase>(
      create: (_) => database,
      child: OKToast(
        backgroundColor: Color.fromRGBO(80, 80, 80, 1),
        radius: 30,
        duration: Duration(seconds: 5),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: "/start",
          routes: {
            "/start": (context) => StartScreen(),
            "/lifeAreas": (context) => LifeAreas(),
            "/importantPersons": (context) => ImportantPersons(),
            "/personDialog": (context) => PersonDialog(),
            "/visualization": (context) => MyVisualization(),
            "/strengths": (context) => Strengths(),
            "/weaknesses": (context) => Weaknesses(),
            "/improvements": (context) => Improvements(),
            "/nameIt": (context) => NameIt(),
            "/WhoCanHelp": (context) => WhoCanHelp(),
            "/SurveyPart1": (context) => SurveyPart1(),
            "/SurveyPart2": (context) => SurveyPart2(),
            "/SurveyPart3": (context) => SurveyPart3(),
            "/SurveyPart4": (context) => SurveyPart4(),
            "/SurveyPart5": (context) => SurveyPart5(),
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
