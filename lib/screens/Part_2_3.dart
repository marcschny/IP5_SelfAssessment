import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/questionCard.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/screens/Part_2_4.dart';

class Part_2_3 extends StatefulWidget {
  const Part_2_3({Key key}) : super(key: key);

  @override
  _Part_2_3State createState() => _Part_2_3State();
}

class _Part_2_3State extends State<Part_2_3> {

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
                  subtitle: "Jetzt packe ich es an!",
                  intro: "Wähle die Frage aus, welche Dich am meisten anspricht  und beantworte sie anschliessend.",
                  percent: 0.4,
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                  child: Wrap(
                    children: [
                      QuestionCard(
                        questionNumber: "2.3.1",
                        question: "Welches sind die beiden wichtigsten Situationen, die Du gerne anders hinkriegen möchtest?",
                        answered: false,
                      ),

                      QuestionCard(
                        questionNumber: "2.3.2",
                        question: "Wenn Du jetzt nochmals über schwierige soziale Situationen (und auch über das Motto der Person, "
                            "die Du gerne wärst!) nachdenkst: Welche Verhaltensweisen möchtest Du verändern? Welche neuen Verhaltensweisen "
                            "wünscht Du Dir? ",
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
            nextTitle: "Lust auf etwas Neues!",
            callbackBack: () {
              Navigator.of(context).pop();
            },
            callbackNext: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Part_2_4()));
            }
          ),
        ],
        ),
      ),

    );

  }
}
