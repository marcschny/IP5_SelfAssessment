import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/database/database_initial_data.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/screens/0_Start.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';

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
    return MaterialApp(
      title: 'Self Assessment Social Relationships',
      //theme: tbd
      home: StartScreen(),
      routes: {
        "/start": (context) => StartScreen(),
      },
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
