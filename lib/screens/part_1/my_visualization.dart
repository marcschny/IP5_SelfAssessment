import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/bottom_navigation.dart';
import 'package:ip5_selbsteinschaetzung/components/circle_trianlge_painter.dart';
import 'package:ip5_selbsteinschaetzung/components/info_button.dart';
import 'package:ip5_selbsteinschaetzung/components/legend_element.dart';
import 'package:ip5_selbsteinschaetzung/components/person_circle.dart';
import 'package:ip5_selbsteinschaetzung/components/top_bar.dart';
import 'package:ip5_selbsteinschaetzung/components/your_person_circle.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/person.dart';
import 'package:ip5_selbsteinschaetzung/components/animations/fade_in.dart';
import 'package:ip5_selbsteinschaetzung/resources/visualization_methods.dart';
import 'package:ip5_selbsteinschaetzung/screens/part_2/strengths.dart';
import 'package:provider/provider.dart';
import 'package:super_tooltip/super_tooltip.dart';



//Screen 1.3
class MyVisualization extends StatefulWidget{

  final int assessmentId;
  final int visualizationId;

  const MyVisualization({
    Key key,
    @required this.assessmentId,
    @required this.visualizationId
  }) : super(key: key);

  _MyVisualizationState createState() => _MyVisualizationState();

}


class _MyVisualizationState extends State<MyVisualization>{

  SuperTooltip tooltip;

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


  //create legend
  _createLegend(){

    //temporary sector number
    int tempSector = 1;

    //create a LegendElement for each sector
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
    //reset temporary sector number
    tempSector = 1;
  }


  //create list of person circles
  _createPersonCircleList(){

    //fist make sure list is empty
    personCircleList.clear();

    //default space (when multiple persons have same area and distance)
    double space = 20;
    //temporary list of persons
    List<Person> tempPersonList = List();

    //create your person (put in center of visualization)
    var yourPerson = Positioned(
      top: MediaQuery.of(context).size.width/2-20,
      left: MediaQuery.of(context).size.width/2-20,
      child: YourPersonCircle(name: "Ich"),
    );
    //add your person to personCircleList
    personCircleList.add(yourPerson);


    //add each person as a PersonCircle widget in personCircleList
    personList.forEach((element) {
      int sector;
      double startAngle;
      int multiplicator = 1;

      sector = lifeAreas.indexOf(element.lifeArea);

      //if person with same area and distance already exists: increment multiplicator
      if(tempPersonList.length > 0) {
        tempPersonList.forEach((person) {
          if (person.lifeArea == element.lifeArea && person.distance == element.distance) {
            multiplicator++;
          }
        });
      }

      tempPersonList.add(element);

      startAngle = getStartSectorAngle(sector+1, lifeAreas.length);

      //add person to personCircleList with proper positioning
      personCircleList.add(
        Positioned(
          top: computeYPosition(element.distance.toInt()+2, startAngle+(space*multiplicator), centerY, radius),
          left: computeXPosition(element.distance.toInt()+2, startAngle+(space*multiplicator), centerX, radius),
          child: PersonCircle(person: element),
        ),
      );
    });

    //clear temporary person list
    tempPersonList.clear();

  }


  //get persons from db
  _getPersons() async{
    //initialize app db
    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;

    final persons = await assessmentRepo.getAllPersonsByVisualization(widget.visualizationId);

    setState(() {
      personList = persons;
      personList.forEach((element) {
        if(!lifeAreas.contains(element.lifeArea)) {
          lifeAreas.add(element.lifeArea);
        }
      });
    });

    //then create list of personCircles and the legend
    _createPersonCircleList();
    _createLegend();

  }



  @override
  Widget build(BuildContext context) {

    //canvas variables
    centerX = MediaQuery.of(context).size.width/2-20;
    centerY = MediaQuery.of(context).size.width/2-20;
    radius = (MediaQuery.of(context).size.width-40)/2;


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
            Container(
              padding: EdgeInsets.only(top: 140, bottom: 94),
              child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                    FadeIn(
                      1,
                      600,
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              child: Center(
                                child: CustomPaint(
                                  child: Container(
                                    height: MediaQuery.of(context).size.width,
                                  ),
                                  painter: WheelPainter(
                                    noAreas: lifeAreas.length,
                                    widgetSize: MediaQuery.of(context).size.width-40,
                                  ),
                                ),
                              ),
                            ),

                            //info button
                            Positioned(
                              top: 8,
                              right: 10,
                              child: InfoButton(text: "Scrolle nach unten falls die Legende nicht sichtbar ist!", tooltipDirection: TooltipDirection.left),
                            ),

                            ]..addAll(personCircleList),
                          ),
                      ),
                      ),

                      FadeIn(
                        1.25,
                        500,
                        Container(
                          padding: EdgeInsets.fromLTRB(18, 10, 18, 5),
                          width: MediaQuery.of(context).size.width,
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            verticalDirection: VerticalDirection.down,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [

                            ]..addAll(legendList),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
            ),

            //absolute positioned top bar
            Positioned(
              top: 0,
              left: 0,
              child: TopBar(
                title: "Wer ist mir wichtig?\nMeine Visualisierung",
                titleNumber: 1,
                subtitle: "So sieht deine Visualisierung aus",
                percent: 0.2,
                intro: "Tippe auf eine Person, um den Namen zu sehen.",
                showProgressbar: true,
              ),
            ),

            //bottom navigation bar
            BottomNavigation(
              showNextButton: true,
              showBackButton: true,
              nextTitle: "Hey, das kann ich bereits!",
              callbackNext: (){
                _next(context, widget.assessmentId, widget.visualizationId);
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

  void _next(BuildContext context, int assessmentId, int visualizationId) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Strengths(assessmentId: assessmentId, visualizationId: visualizationId);
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