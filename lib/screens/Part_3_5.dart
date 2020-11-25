import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/expandableQuestionCard.dart';
import 'package:ip5_selbsteinschaetzung/components/questionCard.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';

import 'Part_2_2.dart';
import 'Part_2_4.dart';

class Part_3_5 extends StatefulWidget {
  const Part_3_5({Key key}) : super(key: key);

  @override
  _Part_3_5State createState() => _Part_3_5State();
}

class _Part_3_5State extends State<Part_3_5> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children:[
            Image.asset(
              //background image
              "assets/background_image/gradient-grey.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),

            Column(
            children: [
              TopBar(
                title: "Ich und andere Menschen:  Wie ich bin und werden möchte II",
                titleNumber: 3,
                onClose: null,
                subtitle: "Auswertung Fragebogen",
                intro: "Folgende Punkte sind Dir bisher weniger gut gelungen. "
                    " Wähle eines davon aus, an welchem Du gerne als  Veränderungsprojekt arbeiten möchtest",
                percent: 0.55,
              ),

              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    children: [
                  ],
                  ),
                ),
              ),

            ],
            ),

            BottomNavigation(
                showNextButton: true,
                showBackButton: false,
                nextTitle: "Lust auf etwas Neues?",
                callbackBack: () {
                  Navigator.of(context).pop();
                },

                callbackNext: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Part_2_4()));
                }

            ),
        ],
        ),
      ),

    );

  }
}
