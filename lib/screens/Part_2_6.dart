import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/questionCard.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';


class Part_2_6 extends StatefulWidget {
  const Part_2_6({Key key}) : super(key: key);

  @override
  _Part_2_6State createState() => _Part_2_6State();
}

class _Part_2_6State extends State<Part_2_6> {

  int assessmentId;

  @override
  Widget build(BuildContext context) {

    assessmentId = ModalRoute.of(context).settings.arguments;

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
                  subtitle: "Wer oder was hilft Dir dabei?",
                  intro: "",
                  percent: 0.55,
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(18, 20, 18, 94),
                    child: Wrap(
                      children: [
                        QuestionCard(
                          questionNumber: "2.6.1",
                          assessmentId: assessmentId,
                        ),

                        QuestionCard(
                          questionNumber: "2.6.2",
                          assessmentId: assessmentId,
                        ),

                        QuestionCard(
                          questionNumber: "2.6.3",
                          assessmentId: assessmentId,
                        ),

                      ],
                  ),
                ),
              ),

              //todo: add network card button (maybe as a alert box)
            ],
          ),


          BottomNavigation(
              showNextButton: true,
              showBackButton: true,
              nextTitle: "Jetzt packe ich es an!",
              callbackBack: () {
                Navigator.of(context).pop();
              },
              callbackNext: (){
                //todo: go to change project
                print("Go to change project...");
                //Navigator.of(context).pushNamed("/part_4", arguments: assessmentId);
              }
          ),
        ],
        ),
      ),

    );

  }
}
