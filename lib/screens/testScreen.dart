

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';

class TestScreen extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TopBar(
          title: "Wer ist mir wichtig?\nMeine Netzwerkkarte",
          titleNumber: 1,
          onClose: (){print("close assessment");},
          subtitle: "Lebensbereiche",
          intro: "Für eine Übersicht über dein persönliches Netzwerk kannst Du zuerst auswählen, welchen Lebensbereichen Du die verschiedenen Personen zuordnen möchtest: Welches sind für Dich relevante Lebensbereiche? ",
        ),
      ),
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