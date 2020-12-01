import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/legendElement.dart';
import 'package:ip5_selbsteinschaetzung/components/personCircle.dart';
import 'package:ip5_selbsteinschaetzung/components/yourPersonCircle.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/person.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';
import 'package:provider/provider.dart';

import 'CircleTrianlgePainter.dart';

class NetworkcardDialog extends StatefulWidget{

  final int assessmentId;
  final int networkId;


  const NetworkcardDialog({
    Key key,
    @required this.assessmentId,
    @required this.networkId,
  }) : super(key: key);


  _NetworkcardDialogState createState() => _NetworkcardDialogState();

}

class _NetworkcardDialogState extends State<NetworkcardDialog>{


  //necessary lists
  List<String> lifeAreas;
  List<Person> personList;
  List<Widget> personCircleList;
  List<LegendElement> legendList;

  //initial distance
  int distance = 0;

  //canvas variables
  double centerX;
  double centerY;
  double radius;

  @override
  void initState() {
    super.initState();
    lifeAreas = List();
    personList = List();
    personCircleList = List();
    legendList = List();
    Future.delayed(Duration.zero, _getPersons);
  }


  @override
  void dispose() {
    super.dispose();
  }

  //computations methods for positioning the person circles
  double _computeXPosition(int distance, double angle){
    return centerX + ((radius/10)*distance) * cos(_toRadian(angle));
  }

  double _computeYPosition(int distance, double angle){
    return centerY + ((radius/10)*distance) * sin(_toRadian(angle));
  }

  double _toRadian(double angle){
    return angle * (pi / 180);
  }

  //create legend
  _createLegend(){

    int tempSector = 1;

    lifeAreas.forEach((element) {
      legendList.add(
          LegendElement(
            sector: tempSector,
            sectorName: element,
          )
      );
      tempSector++;
    });

    setState(() { });
    tempSector = 1;
  }

  //create person circle list
  _createPersonCircleList(){

    personCircleList.clear();

    double space = 22; //default space (when multiple persons have same life area and distance)
    List<Person> tempPersonList = List();


    var yourPerson = Positioned(
      top: MediaQuery.of(context).size.width/2-40,
      left: MediaQuery.of(context).size.width/2-20,
      child: YourPersonCircle(name: "Du"),
    );
    personCircleList.add(yourPerson);


    personList.forEach((element) {
      int sector;
      double startAngle;
      int multiplicator = 1;

      sector = lifeAreas.indexOf(element.lifeArea);

      if(tempPersonList.length > 0) {
        tempPersonList.forEach((person) {
          if (person.lifeArea == element.lifeArea && person.distance == element.distance) {
            multiplicator++;
          }
        });
      }

      tempPersonList.add(element);

      startAngle = _getStartSectorAngle(sector+1);

      personCircleList.add(
        Positioned(
          top: _computeYPosition(element.distance.toInt()+2, startAngle+(space*multiplicator)),
          left: _computeXPosition(element.distance.toInt()+2, startAngle+(space*multiplicator)),
          child: PersonCircle(person: element),
        ),
      );
    });

    tempPersonList.clear();

  }

  //get the starting angle point from sector
  double _getStartSectorAngle(int sector){
    int noLifeAreas = lifeAreas.length;
    if(noLifeAreas == 2){
      switch(sector){
        case 1:
          return 180;
          break;
        case 2:
          return 0;
          break;
      }
    }else if(noLifeAreas == 3){
      switch(sector){
        case 1:
          return 240;
          break;
        case 2:
          return 120;
          break;
        case 3:
          return 0;
          break;
      }
    }else if(noLifeAreas == 4){
      switch(sector){
        case 1:
          return 90;
          break;
        case 2:
          return 0;
          break;
        case 3:
          return 270;
          break;
        case 4:
          return 180;
          break;
      }
    }else if(noLifeAreas == 5){
      switch(sector){
        case 1:
          return 0;
          break;
        case 2:
          return 288;
          break;
        case 3:
          return 216;
          break;
        case 4:
          return 144;
          break;
        case 5:
          return 72;
          break;
      }
    }else if(noLifeAreas == 6){
      switch(sector){
        case 1:
          return 300;
          break;
        case 2:
          return 240;
          break;
        case 3:
          return 180;
          break;
        case 4:
          return 120;
          break;
        case 5:
          return 60;
          break;
        case 6:
          return 0;
          break;
      }
    }else{
      return -1000;
    }
  }

  //get persons from db
  _getPersons() async{
    //initialize app db
    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;

    final persons = await assessmentRepo.getAllPersonsByNetworkCard(widget.networkId);

    setState(() {
      personList = persons;
      personList.forEach((element) {
        if(!lifeAreas.contains(element.lifeArea)) {
          lifeAreas.add(element.lifeArea);
        }
      });
    });

    //then create legend
    _createLegend();

  }


  @override
  Widget build(BuildContext context) {


    //canvas variables
    centerX = MediaQuery.of(context).size.width/2-20;
    centerY = MediaQuery.of(context).size.width/2-40;
    radius = (MediaQuery.of(context).size.width-40)/2;


    _createPersonCircleList();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: 94),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  padding: EdgeInsets.symmetric(vertical: 28, horizontal: 18),
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "So sieht Deine Karte aus",
                    style: ThemeTexts.assessmentSubtitle,
                  ),
                ),




                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Center(
                        child: CustomPaint(
                          child: Container(
                            height: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(20),
                          ),
                          painter: WheelPainter(
                            noAreas: lifeAreas.length,
                            widgetSize: MediaQuery.of(context).size.width-40,
                          ),
                        ),
                      ),
                    ),

                  ]..addAll(personCircleList),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(18, 10, 18, 5),
                  width: MediaQuery.of(context).size.width,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    children: [

                    ]..addAll(legendList),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.only(right: 8, bottom: 8),
        child: ButtonTheme(
          height: 60,
          minWidth: 60,
          child: RaisedButton(
            elevation: 0.0,
            color: ThemeColors.greyShade1,
            shape: CircleBorder(),
            child: Icon(
              Icons.arrow_back,
              color: Color.fromRGBO(80, 80, 80, 1),
            ),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      resizeToAvoidBottomInset: false,
    );
  }


}