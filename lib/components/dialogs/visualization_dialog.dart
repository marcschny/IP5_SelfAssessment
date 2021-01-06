import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/circle_trianlge_painter.dart';
import 'package:ip5_selbsteinschaetzung/components/legend_element.dart';
import 'package:ip5_selbsteinschaetzung/components/person_circle.dart';
import 'package:ip5_selbsteinschaetzung/components/your_person_circle.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/person.dart';
import 'package:ip5_selbsteinschaetzung/resources/animations/fade_in.dart';
import 'package:ip5_selbsteinschaetzung/resources/visualization_methods.dart';
import 'package:ip5_selbsteinschaetzung/themes/assessment_theme.dart';
import 'package:provider/provider.dart';


class VisualizationDialog extends StatefulWidget{

  final int assessmentId;
  final int visualizationId;


  const VisualizationDialog({
    Key key,
    @required this.assessmentId,
    @required this.visualizationId,
  }) : super(key: key);


  _VisualizationDialogState createState() => _VisualizationDialogState();

}

class _VisualizationDialogState extends State<VisualizationDialog>{


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

    double space = 20; //default space (when multiple persons have same life area and distance)
    List<Person> tempPersonList = List();


    var yourPerson = Positioned(
      top: MediaQuery.of(context).size.width/2-20,
      left: MediaQuery.of(context).size.width/2-20,
      child: YourPersonCircle(name: "Ich"),
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

      startAngle = getStartSectorAngle(sector+1, lifeAreas.length);

      personCircleList.add(
        Positioned(
          top: computeYPosition(element.distance.toInt()+2, startAngle+(space*multiplicator), centerY, radius),
          left: computeXPosition(element.distance.toInt()+2, startAngle+(space*multiplicator), centerX, radius),
          child: PersonCircle(person: element),
        ),
      );
    });

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

    //then create list of personCircles
    _createPersonCircleList();
    //then create legend
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
        child: FadeIn(
          1.32,
          500,
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(bottom: 94),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    padding: EdgeInsets.fromLTRB(18, 30, 18, 24),
                    child: Text(
                      "So sieht Deine Visualisierung aus",
                      style: ThemeTexts.assessmentSubtitle,
                    ),
                  ),




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

                      ]..addAll(personCircleList),
                    ),
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