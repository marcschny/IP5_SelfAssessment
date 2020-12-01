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
                  subtitle: "Jetzt packe ich es an!",
                  intro: "Wähle die Frage, die Dich am meisten anspricht und beantworte sie anschliessend.",
                  percent: 0.4,
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(18, 20, 18, 94),
                    child: Wrap(
                      children: [
                        QuestionCard(
                          questionNumber: "2.3.1",
                          assessmentId: assessmentId,
                        ),

                        QuestionCard(
                          questionNumber: "2.3.2",
                          assessmentId: assessmentId,
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
            nextTitle: "Lust auf etwas Neues!",
            callbackBack: () {
              Navigator.of(context).pop();
            },
            callbackNext: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Part_2_4(assessmentId: assessmentId),
                ),
              );

            }
          ),
        ],
        ),
      ),

    );

  }
}
