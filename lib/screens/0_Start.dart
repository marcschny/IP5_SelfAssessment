import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/CurvedShape.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';

class StartScreen extends StatefulWidget {

  const StartScreen({Key key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();

}

class _StartScreenState extends State<StartScreen>{

  int _currentIndex = 0;

  List pageList = [
    Part0(),
    Part1(),
    Part2(),
    Part3(),
    Part4(),
    Part5(),
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        text: "Kurz Assessment\n",
                        style: ThemeTexts.startAssessmentTitle
                      ),
                      TextSpan(
                        text: "Soziale Beziehungen",
                        style: ThemeTexts.startAssessmentSubtitle
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
                  print('pressed "Starten"');
                },
              ),
            ),
          )

        ],
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
            ],
          ),

        ),
      ),
    );
  }
}

class Part1 extends StatelessWidget {
  const Part1({Key key}) : super(key: key);@override
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
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "In einem ersten Schritt erstellst Du eine  soziale Netzwerkkarte. Dazu wählst Du die für Dich wichtigsten Lebensbereiche und fügst danach Personen hinzu, welche Dir entweder sehr nah sind oder eher etwas weniger nah.\n\n",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black
                  ),
                ),
                TextSpan(
                  text: "Nach Abschluss des Teil 1 siehst Du Deine  Visualisierung der Netzwerkkarte.",
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
  const Part2({Key key}) : super(key: key);@override
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
                    text: "Danach kannst Du mit Hilfe einiger persönlicher Fragen herausfinden, was Du bereits sehr gut kannst im Umgang mit anderen Menschen und wo Du selber noch nicht so zufrieden bist mit Dir. \n\n",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black
                    ),
                  ),
                  TextSpan(
                    text: "Zum Abschluss des Teil 2 machst Du Dir erste Gedanken zu deinem Veränderungsprojekt, welches Du dann starten kannst",
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
                    text: "In einem dritten Teil, welcher optional ist, kannst du mit Hilfe eines dreiteiligen Fragebogens herausfinden, worin Deine Stärken und Schwächen liegen, um damit Dein Veränderungsprojekt starten zu können.",
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
  const Part4({Key key}) : super(key: key);@override
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
                    text: "Teil 4 ist Dein Veränderungsprojekt  “Hey, das kann ich!”. Hier kannst Du täglich Deine Gedanken, Deine Ideen oder Deinen Fortschritt als Notizen festhalten.",
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
  const Part5({Key key}) : super(key: key);@override
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
                    text: "Nach Abschluss Deines Veränderungsprojekts erhälts Du eine visuelle Auswertung Deines Assessments.\n\n\n",
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
                    text: " um das Assessment zu starten !",
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