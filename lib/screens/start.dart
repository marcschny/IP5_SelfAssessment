import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/curved_shape.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/assessment.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/visualization.dart';
import 'package:ip5_selbsteinschaetzung/screens/part_1/areas.dart';
import 'package:ip5_selbsteinschaetzung/themes/assessment_theme.dart';
import 'package:provider/provider.dart';

class Start extends StatefulWidget {

  final Assessment existingAssessment;


  const Start({Key key, this.existingAssessment}) : super(key: key);

  _StartState createState() => _StartState();


}

class _StartState extends State<Start>{


  //index for intro pageView
  int _currentIndex = 0;

  //list of pages for pageView
  List pageList = [
    Part0(),
    Part1(),
    Part2(),
    Part3(),
    Part4(),
    Part5(),
  ];


  //page view builder
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }


  //start assessment
  void _startAssessment(BuildContext context){
    final Assessment newAssessment = new Assessment(null, null, null, DateTime.now().toString(), null);

    final appDataBase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDataBase.assessmentRepository;
    assessmentRepo.createAssessment(newAssessment).then((assessmentId) {
      final Visualization newVisualization = new Visualization(null, assessmentId, 0, "");
      assessmentRepo.createVisualization(newVisualization).then((visualizationId) {
        print(assessmentId.toString()+", "+visualizationId.toString());
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return LifeAreas(assessmentId: assessmentId, visualizationId: visualizationId);
              //return Strengths(assessmentId: assessmentId, visualizationId: 1);

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
      });

    });
  }


  //check if its a new or existing assessment
  _checkIfExistingAssessment(){
    //if constructor has retrieved an assessment, thne navigate to change project [part 4]
    if(widget.existingAssessment != null){
      Navigator.of(context).pushNamed("/part_4", arguments: widget.existingAssessment.id);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _checkIfExistingAssessment);
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.of(context).canPop();
      },
      child: Scaffold(
        body: Stack(
          children: [

            //background image
            Image.asset(
              "assets/background_image/gradient-grey.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),


            //custom curved shape (fills entire screen)
            Positioned(
              top: 0,
              left: 0,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Container(
                color: Colors.transparent,
                child: CustomPaint(
                  painter: CurvedShape(ThemeColors.greenShade1, ThemeColors.greenShade3),
                ),
              ),
            ),


            //assessment top titles
            Positioned(
              top: 0,
              left: 0,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.25,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Center(
                  child: RichText(
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Freund*innen und Beziehungen",
                          style: ThemeTexts.startAssessmentTitle
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),


            //intro texts
            Positioned(
              top: MediaQuery.of(context).size.height*0.25+20,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.45,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: PageController(
                        viewportFraction: 1,
                      ),
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemCount: pageList.length,
                      itemBuilder: (context, index){
                        return pageList[index];
                      },
                    ),
                  ),

                  //pageview dots
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(pageList.length, (i){
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          width: 11,
                          height: 11,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: _currentIndex == i
                                    ? Colors.transparent
                                    : Color.fromRGBO(200, 200, 200, 1)
                              ),
                              color: _currentIndex == i
                                  ? Color.fromRGBO(200, 200, 200, 1)
                                  : Colors.transparent
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                ],
              ),
            ),



            //start button
            Positioned(
              bottom: 40,
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: Center(
                child: RaisedButton(
                  color: ThemeColors.greenShade2,
                  padding: EdgeInsets.symmetric(vertical: 11, horizontal: 34),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)
                  ),
                  elevation: 5.0,
                  child: Text(
                    "Starten",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.8,
                    ),
                  ),
                  onPressed: (){
                    _startAssessment(context);
                  },
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

}


class Part0 extends StatelessWidget {
  const Part0({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "Kontakte mit anderen Menschen sind für uns alle lebenswichtig.\n\n\n",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17
                ),
              ),
              WidgetSpan(
                child: Image.asset("assets/illustrations/flowchart.png"),
              ),
              TextSpan(
                text: "\n\nWische nach links um mehr über dieses Assessment zu erfahren. ",
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: 15.5
                ),
              ),
              WidgetSpan(
                child: Icon(Icons.swipe, size: 20, color: Colors.black26),
              ),
            ],
          ),

        ),
      ),
    );
  }
}

class Part1 extends StatelessWidget {
  const Part1({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 14),
          child: Center(
            child: Image.asset("assets/illustrations/Part1.png", height: 94),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child:
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "In einem ersten Schritt erstellst Du eine  Visualisierung deines sozialen Umfelds. Dazu wählst Du die für Dich wichtigsten Bereiche aus und fügst anschliessend Personen hinzu, welche Dir entweder sehr wichtig oder eher weniger wichtig sind.\n\n",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black
                  ),
                ),
                TextSpan(
                  text: "Zum Abschluss des ",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black
                  ),
                ),
                TextSpan(
                  text: "Teil 1",
                  style: TextStyle(
                    fontSize: 15,
                    color: ThemeColors.greenShade1,
                    fontWeight: FontWeight.bold
                  ),
                ),
                TextSpan(
                  text: " erhälst Du Deine Visualisierung.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black
                  ),
                ),
              ]
            ),
          ),
        ),
      ],
    );
  }
}

class Part2 extends StatelessWidget {
  const Part2({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 14),
          child: Center(
            child: Image.asset("assets/illustrations/Part2.png", height: 94),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                children: [
                  TextSpan(
                    text: "Im zweiten Teil kannst Du mit Hilfe einiger persönlicher Fragen herausfinden, was Du bereits sehr gut kannst im Umgang mit anderen Menschen und wo Du selber noch nicht so zufrieden bist mit Dir. \n\n",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black
                    ),
                  ),
                  TextSpan(
                    text: "Zum Abschluss des ",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black
                    ),
                  ),
                  TextSpan(
                    text: "Teil 2",
                    style: TextStyle(
                        fontSize: 15,
                        color: ThemeColors.greenShade1,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  TextSpan(
                    text: " machst Du Dir erste Gedanken zu Deinem Veränderungsprojekt, welches Du dann im ",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black
                    ),
                  ),
                  TextSpan(
                    text: "Teil 4",
                    style: TextStyle(
                        fontSize: 15,
                        color: ThemeColors.greenShade1,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  TextSpan(
                    text: " starten kannst.",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black
                    ),
                  ),
                ]
            ),
          ),
        ),
      ],
    );
  }
}

class Part3 extends StatelessWidget {
  const Part3({Key key}) : super(key: key);@override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 14),
          child: Center(
            child: Image.asset("assets/illustrations/Part3.png", height: 94),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                children: [
                  TextSpan(
                    text: "In einem dritten Teil, welcher optional ist, kannst Du mit Hilfe eines dreiteiligen Fragebogens herausfinden, worin Deine Stärken und Schwächen liegen. Dies hilft Dir bei der Wahl Deines Veränderungsprojekts",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black
                    ),
                  ),
                ]
            ),
          ),
        ),
      ],
    );
  }
}

class Part4 extends StatelessWidget {
  const Part4({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 14),
          child: Center(
            child: Image.asset("assets/illustrations/Part4.png", height: 94),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                children: [
                  TextSpan(
                    text: "Teil 4",
                    style: TextStyle(
                        fontSize: 15,
                        color: ThemeColors.greenShade1,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  TextSpan(
                    text: " ist Dein Veränderungsprojekt ",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black
                    ),
                  ),
                  TextSpan(
                    text: " “Das möchte ich gerne können!”",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black
                    ),
                  ),
                  TextSpan(
                    text: "  Hier kannst Du während zwei bis drei Wochen an Dir arbeiten und festhalten was Dir dabei gut und weniger gut gelungen ist.",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black
                    ),
                  ),
                ]
            ),
          ),
        ),
      ],
    );
  }
}

class Part5 extends StatelessWidget {
  const Part5({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 14),
          child: Center(
            child: Image.asset("assets/illustrations/Part5.png", height: 94),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                children: [
                  TextSpan(
                    text: "Nach Abschluss Deines Veränderungsprojekts erhälts Du im ",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black
                    ),
                  ),
                  TextSpan(
                    text: "Teil 5",
                    style: TextStyle(
                        fontSize: 15,
                        color: ThemeColors.greenShade1,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  TextSpan(
                    text: " eine Auswertung davon.\n\n\n",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black
                    ),
                  ),
                  TextSpan(
                    text: "Tippe unten auf ",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: "Starten",
                    style: TextStyle(
                      fontSize: 15,
                      color: ThemeColors.greenShade2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: " um das Assessment zu starten!",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ]
            ),
          ),
        ),
      ],
    );
  }
}