import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/database/database_initial_data.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
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
          child: Center(
        child: Text(
          "Hello World",
          style: TextStyle(fontSize: 20),
        ),
      )),
    );
  }
}
