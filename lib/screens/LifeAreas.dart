import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/CheckBoxComponent.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';



//Screen 1.1
class LifeAreas extends StatefulWidget{

  const LifeAreas({Key key});

  _LifeAreasState createState() => _LifeAreasState();

}

class _LifeAreasState extends State<LifeAreas>{

  TextEditingController _textController = TextEditingController();
  List<CheckBoxComponent> list = List();


  List<String> _listData = [
    "Familie",
    "Freunde*Innen im Heim/WG",
    "Freunde*Innen ausserhalb",
    "Sozialpädagogen*Innen im Heim/WG",
    "Schule / Ausbildung / Arbeit",
    "Verein / Hobby",
    "Tiere",
  ];




  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
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

            //content
            Column(
              children: [


                TopBar(
                  title: "Wer ist mir wichtig?\nMeine Netzwerkkarte",
                  titleNumber: 1,
                  onClose: null,
                  subtitle: "Lebensbereiche",
                  percent: 0.1,
                  intro: "Für eine Übersicht über dein persönliches Netzwerk kannst Du zuerst auswählen, welchen Lebensbereichen Du die verschiedenen Personen zuordnen möchtest: Welches sind für Dich relevante Lebensbereiche? ",
                ),

                _customCheckBox(),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 94),
                    child: ListView.builder(
                      itemCount: _listData.length,
                      itemBuilder: (context, index){
                        return CheckBoxComponent(checkboxTitle: _listData[index]);
                      },
                    ),
                  ),
                ),

              ],
            ),

            //bottom navigation bar
            BottomNavigation(
              showNextButton: true,
              showBackButton: false,
              nextTitle: "Wichtige Personen",
              callbackNext: (){

              },
            ),
          ],
        ),
      ),
    );
  }


  _customCheckBox(){
    return Container(
        padding: EdgeInsets.fromLTRB(10, 0, 16, 0),
        margin: EdgeInsets.only(bottom: 8),
        child: Row(
            children: [
              Checkbox(
                value: false,
              ),
              Expanded(
                child: TextField(
                  maxLines: 1,
                  controller: _textController,
                  onSubmitted: (value){
                    _onSubmit(value);
                  },
                  decoration: InputDecoration(
                    hintText: "Neuer Lebensbereich hinzufügen...",
                    hintStyle: ThemeTexts.assessmentText.copyWith(fontSize: 18, color: Colors.grey),
                    contentPadding: EdgeInsets.only(bottom: 0)
                  ),
                  style: ThemeTexts.assessmentText,
                ),
              )
            ]
        )
    );
  }


  _onSubmit(String value){
    print(value);
    _listData.insert(0, value);
    _textController.clear();
    setState(() {});
  }




}