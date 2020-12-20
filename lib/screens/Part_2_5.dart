import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/assessment.dart';
import 'package:ip5_selbsteinschaetzung/resources/FadeIn.dart';
import 'package:ip5_selbsteinschaetzung/screens/Part_2_6.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';
import 'package:provider/provider.dart';



class Part_2_5 extends StatefulWidget {

  final int assessmentId;
  final int visualizationId;

  const Part_2_5({
    Key key,
    this.assessmentId,
    this.visualizationId
  }) : super(key: key);

  @override
  _Part_2_5State createState() => _Part_2_5State();
}

class _Part_2_5State extends State<Part_2_5>{


  TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = new TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }



  setProjectTitle() async{
    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;

    String projectTitle;
    projectTitle = _titleController.text != null && _titleController.text != "" ? _titleController.text : "Mein Veränderungsprojekt";


    final thisAssessment = await assessmentRepo.findAssessment(widget.assessmentId);
    final updateAssessment = Assessment(widget.assessmentId, projectTitle, null, thisAssessment.date_created, "");

    assessmentRepo.updateAssessment(updateAssessment);

    print("set project title to: "+projectTitle);
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
                  subtitle: "Name it!",
                  intro: "Wie lautet der Titel deines Veränderungsprojekts?",
                  percent: 0.5,
                  showProgressbar: true,
              ),

              Expanded(
                child: FadeIn(
                  1.1,
                  500,
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 30, 34, 20),
                      child: Wrap(
                        children: [
                          TextField(
                            maxLines: 1,
                            controller: _titleController,
                            onSubmitted: (value){ },
                            textInputAction: TextInputAction.go,
                            decoration: InputDecoration(
                              hintText: "Titel hier eingeben...",
                              hintStyle: ThemeTexts.assessmentText.copyWith(fontSize: 20.5, color: Colors.grey, fontWeight: FontWeight.w500),
                              contentPadding: EdgeInsets.all(0),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: ThemeColors.greenShade3),
                              ),
                            ),
                            style: ThemeTexts.assessmentText.copyWith(fontSize: 20),
                          ),
                        ],
                      ),
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
                  _next(context, widget.assessmentId, widget.visualizationId);
                }
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );

  }


  void _next(BuildContext context, int assessmentId, int visualizationId){

    setProjectTitle();

    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Part_2_6(assessmentId: assessmentId, visualizationId: visualizationId);
        },
        transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return Align(
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
      ),
    );
  }

}
