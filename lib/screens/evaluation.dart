

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:provider/provider.dart';

class Evaluation extends StatefulWidget{

  final int assessmentId;

  const Evaluation({Key key, this.assessmentId}) : super(key: key);

  _EvaluationState createState() => _EvaluationState();

}

class _EvaluationState extends State<Evaluation>{

  String projectTitle = "";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _getProjectTitle);

  }


  _getProjectTitle() async{
    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;

    final assessment = await assessmentRepo.getProjectTitle(widget.assessmentId);

    setState(() {
      projectTitle = assessment?.project_title != null ? assessment.project_title : "Kein Projekttitel";
    });

    print(assessment?.project_title);

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [

            //background image
            Image.asset(
              "assets/background_image/gradient-grey.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                TopBar(
                  title: "Auswertung",
                  titleNumber: 5,
                  onClose: null,
                  subtitle: projectTitle,
                  percent: 0.05,
                  intro: "",
                  showProgressbar: false,
                ),


              ],
            ),

          ],
        ),
      ),
    );
  }




}