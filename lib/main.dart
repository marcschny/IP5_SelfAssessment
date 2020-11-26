import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/database/database_initial_data.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/screens/Part_2_1.dart';
import 'package:ip5_selbsteinschaetzung/screens/Part_2_2.dart';
import 'package:ip5_selbsteinschaetzung/screens/Part_2_3.dart';
import 'package:ip5_selbsteinschaetzung/screens/Part_2_4.dart';
import 'package:ip5_selbsteinschaetzung/screens/Part_2_5.dart';
import 'package:ip5_selbsteinschaetzung/screens/Part_2_6.dart';
import 'package:ip5_selbsteinschaetzung/screens/Part_3_1.dart';
import 'package:ip5_selbsteinschaetzung/screens/Part_3_2.dart';
import 'package:ip5_selbsteinschaetzung/screens/Part_3_3.dart';
import 'package:ip5_selbsteinschaetzung/screens/Part_3_4.dart';
import 'package:ip5_selbsteinschaetzung/screens/Part_3_5.dart';
import 'package:ip5_selbsteinschaetzung/screens/0_Start.dart';
import 'package:ip5_selbsteinschaetzung/screens/LifeAreas.dart';
import 'package:ip5_selbsteinschaetzung/screens/Visualization.dart';
import 'package:ip5_selbsteinschaetzung/screens/importantPersons.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';

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
      //when app is opened
      onOpen: (database) async {
    //tbd
  },
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
    return Provider<AppDatabase>(
      create: (_) => database,
      child: OKToast(
        backgroundColor: Color.fromRGBO(80, 80, 80, 1),
        radius: 30,
        duration: Duration(seconds: 5),
        child: MaterialApp(
          initialRoute: "/start",
          routes: {
            "/start": (context) => StartScreen(),
            "/lifeAreas": (context) => LifeAreas(),
            "/importantPersons": (context) => ImportantPersons(),
            "/personDialog": (context) => PersonDialog(),
            "/visualization": (context) => Visualization(),
            "/part_2_1": (context) => Part_2_1(),
            "/part_2_2": (context) => Part_2_2(),
            "/part_2_3": (context) => Part_2_3(),
            "/part_2_4": (context) => Part_2_4(),
            "/part_2_5": (context) => Part_2_5(),
            "/part_2_6": (context) => Part_2_6(),
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
