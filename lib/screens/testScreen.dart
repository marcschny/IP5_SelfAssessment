

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';

class TestScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: Colors.grey),
      bottomNavigationBar: BottomNavigation(
        showBackButton: true,
        showNextButton: true,
        nextTitle: "Wichtige Personen",
        callbackBack: (){print("navigation.pop()");},
        callbackNext: (){print("navigation.pushNamed()");},
      ),
    );
  }

}