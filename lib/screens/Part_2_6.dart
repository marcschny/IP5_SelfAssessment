import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/questionCard.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';

import 'Part_2_3.dart';

class Part_2_6 extends StatefulWidget {
  const Part_2_6({Key key}) : super(key: key);

  @override
  _Part_2_6State createState() => _Part_2_6State();
}

class _Part_2_6State extends State<Part_2_6> {

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
                  subtitle: "Wer oder was hilft Dir dabei?",
                  intro: "",
                  percent: 0.55,
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                  child: Wrap(
                    children: [
                      QuestionCard(
                        questionNumber: "2.6.1",
                        question: "Wer der Jugendlichen könnte Dir dabei helfen? Wen willst Du einweihen und fragen,"
                            " ob er/sie Dich unterstützt?",
                        answered: false,
                      ),

                      QuestionCard(
                        questionNumber: "2.6.2",
                        question: "Die SozialpädagogInnen in der WG sind ja dazu da, Dich zu unterstützen. "
                            " Wen willst Du einbeziehen in Dein «Hey, das kann ich»-Projekt/Vorhaben?",
                        answered: false,
                      ),

                      QuestionCard(
                        questionNumber: "2.6.3",
                        question: "Hast Du sonst noch eine Idee, wer oder was Dir bei Deinem Projekt behilflich sein könnte?",
                        answered: false,
                      ),

                    ],
                ),
              ),


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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Part_2_6()));
              }
          ),
        ],
        ),
      ),

    );

  }
}
