import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/questionCard.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';

import 'Part_2_6.dart';

class Part_2_5 extends StatefulWidget {
  const Part_2_5({Key key}) : super(key: key);

  @override
  _Part_2_5State createState() => _Part_2_5State();
}

class _Part_2_5State extends State<Part_2_5> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children:[
            Image.asset(
              "assets/background_image/gradient-grey.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),

            Column(
              children: [
              TopBar(
                  title: "Ich und andere Menschen:  Wie ich bin und werden möchte",
                  titleNumber: 2,
                  onClose: null,
                  subtitle: "Name it!",
                  intro: "Wie lautet der Titel deines “Ja klar, das schaff  ich”-Projekts ?",
                  percent: 0.5,
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                    child: Wrap(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Titel meines Projekts",
                            contentPadding: EdgeInsets.all(0),
                          ),
                        ),



                      ],
                    ),
                ),
              ),
          ],
        ),


              BottomNavigation(
                  showNextButton: true,
                  showBackButton: true,
                  nextTitle: "Wer oder was hilft  Dir dabei?",
                  callbackBack: () {
                    Navigator.of(context).pop();
                  },
                  callbackNext: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Part_2_6()));
                  }
              ),
        ],
        ),
      ),

    );

  }
}
