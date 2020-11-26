import 'dart:collection';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/CircleTrianlgePainter.dart';
import 'package:ip5_selbsteinschaetzung/components/legendElement.dart';
import 'package:ip5_selbsteinschaetzung/components/personCircle.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/components/yourPersonCircle.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/person.dart';
import 'package:provider/provider.dart';


//Screen 1.3
class Visualization extends StatefulWidget{

  const Visualization({
    Key key
  }) : super(key: key);

  _VisualizationState createState() => _VisualizationState();

}

class _VisualizationState extends State<Visualization>{

  //variables from route
  int assessmentId;
  int networkId;
  LinkedHashMap<String, int> routeArgs;

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
      print("las: "+lifeAreas.toString());
      print("ela: "+element.lifeArea);

      if(tempPersonList.length > 0) {
        tempPersonList.forEach((person) {
          if (person.lifeArea == element.lifeArea && person.distance == element.distance) {
            multiplicator++;
          }
          print("element: "+element.id.toString()+", multi: "+multiplicator.toString());
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

    print(tempPersonList);
    tempPersonList.clear();

  }

  //get the starting angle point from sector
  double _getStartSectorAngle(int sector){
    int noLifeAreas = lifeAreas.length;
    print("noLAs: "+noLifeAreas.toString());
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

    final persons = await assessmentRepo.getAllPersonsByNetworkCard(networkId);

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

    //get passed arguments
    routeArgs = ModalRoute.of(context).settings.arguments;
    assessmentId = routeArgs["assessmentId"];
    networkId = routeArgs["networkId"];

    print("width: "+MediaQuery.of(context).size.width.toString());
    print("nID: "+networkId.toString());


    //canvas variables
    centerX = MediaQuery.of(context).size.width/2-20;
    centerY = MediaQuery.of(context).size.width/2-40;
    radius = (MediaQuery.of(context).size.width-40)/2;

    _createPersonCircleList();
    print("pcl.length: "+personCircleList.length.toString());
    print("pcls: "+personCircleList.toString());

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


            //content
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(bottom: 94),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    TopBar(
                      title: "Wer ist mir wichtig?\nMeine Netzwerkkarte",
                      titleNumber: 1,
                      onClose: null,
                      subtitle: "Visualisierung",
                      percent: 0.2,
                      intro: "",
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

            //bottom navigation bar
            BottomNavigation(
              showNextButton: true,
              showBackButton: true,
              nextTitle: "Hey, das kann ich bereits!",
              callbackNext: (){
                _next(context, assessmentId, networkId);
              },
              callbackBack: (){
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _next(BuildContext context, int assessmentId, int networkId) {
    //todo

  }


}