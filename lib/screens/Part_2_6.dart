import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/networkcardDialog.dart';
import 'package:ip5_selbsteinschaetzung/components/questionCard.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/resources/FadeIn.dart';
import 'package:ip5_selbsteinschaetzung/resources/SlideUpFadeIn.dart';
import 'package:ip5_selbsteinschaetzung/resources/SlideUpFromBottom.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';


class Part_2_6 extends StatefulWidget {

  final int assessmentId;
  final int networkId;

  const Part_2_6({
    Key key,
    this.assessmentId,
    this.networkId
  }) : super(key: key);

  @override
  _Part_2_6State createState() => _Part_2_6State();
}

class _Part_2_6State extends State<Part_2_6>{


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


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

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 10, 18, 94),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SlideUpFadeIn(
                        0.5,
                        130,
                        QuestionCard(
                          questionNumber: "2.6.1",
                          assessmentId: widget.assessmentId,
                        ),
                      ),
                      SlideUpFadeIn(
                        0.7,
                        140,
                        QuestionCard(
                          questionNumber: "2.6.2",
                          assessmentId: widget.assessmentId,
                        ),
                      ),
                      SlideUpFadeIn(
                        0.8,
                        140,
                        QuestionCard(
                          questionNumber: "2.6.3",
                          assessmentId: widget.assessmentId,
                        ),
                      ),

                      SizedBox(height: 16),
                      FadeIn(
                        2.9,
                        600,
                        Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Icon(
                                Icons.info_outline_rounded,
                                size: 25,
                                color: Colors.black26,
                              )
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Bei der Wahl Deiner Hilfspersonen könnte Dir Deine soziale Karte weiterhelfen",
                              style: ThemeTexts.assessmentQuestion.copyWith(color: Colors.black26),
                              textAlign: TextAlign.start,
                              softWrap: true,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                      ),


                      FadeIn(
                        3,
                        600,
                        Padding(
                          padding: EdgeInsets.only(left: 32),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            color: ThemeColors.greenShade4,
                            elevation: 0,
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                            highlightColor: ThemeColors.greenShade4,
                            splashColor: Colors.transparent,
                            focusElevation: 0,
                            highlightElevation: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.remove_red_eye_outlined,
                                  size: 20.5,
                                  color: Color.fromRGBO(80, 80, 80, 1),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "Karte anzeigen",
                                  style: ThemeTexts.assessmentDialogSubtitle.copyWith(color: Color.fromRGBO(80, 80, 80, 1), fontSize: 16.5, fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                            onPressed: (){
                              showDialog(
                                context: context,
                                barrierColor: Colors.black.withOpacity(.3),
                                child: SlideUpFromBottom(0, NetworkcardDialog(assessmentId: widget.assessmentId, networkId: widget.networkId)),
                              );
                              print("show social card");
                            },
                          ),
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
