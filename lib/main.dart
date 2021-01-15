import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/database/creation_data_script.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/update_data_script.dart';
import 'package:ip5_selbsteinschaetzung/components/animations/slide_up_toast.dart';
import 'package:ip5_selbsteinschaetzung/routes.dart';
import 'package:ip5_selbsteinschaetzung/themes/assessment_theme.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter/services.dart';


//async main function
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

    //overrides system properties: in this case the status bar color and brightness
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
          routes: routes
        ),
      ),
    );
  }


}

