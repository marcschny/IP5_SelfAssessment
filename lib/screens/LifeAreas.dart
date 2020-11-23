import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/CheckBoxComponent.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/networdcard.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';
import 'package:provider/provider.dart';



//Screen 1.1
class LifeAreas extends StatefulWidget{

  const LifeAreas({Key key});

  _LifeAreasState createState() => _LifeAreasState();

}

class _LifeAreasState extends State<LifeAreas>{

  TextEditingController _textController = TextEditingController();


  Map<String, bool> _lifeAreasMap = {
    "Tiere": false,
    "Verein / Hobby": false,
    "Schule / Ausbildung / Arbeit": false,
    "Sozialpädagogen*Innen im Heim/WG": false,
    "Freunde*Innen ausserhalb": false,
    "Freunde*Innen im Heim/WG": false,
    "Familie": false,
  };


  List<CheckBoxComponent> _widgetList;


  @override
  void initState() {
    super.initState();
    _widgetList = new List();
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final int assessmentId = ModalRoute.of(context).settings.arguments;

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
                  percent: 0.05,
                  intro: "Für eine Übersicht über dein persönliches Netzwerk kannst Du zuerst auswählen, welchen Lebensbereichen Du die verschiedenen Personen zuordnen möchtest: Welches sind für Dich relevante Lebensbereiche? ",
                ),

                _customCheckBox(),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 94),
                    child: ListView.builder(
                      itemCount: _lifeAreasMap.length,
                      itemBuilder: (context, index){
                        return CheckBoxComponent(
                          checkboxTitle: _lifeAreasMap.keys.elementAt(_lifeAreasMap.length-index-1), //count backwards, so the newly added life area appears on top
                          checked: _lifeAreasMap.values.elementAt(_lifeAreasMap.length-index-1),
                          callback: (checkBoxTitle){
                            _switchChecked(checkBoxTitle);
                          }
                        );
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
                _next(context, assessmentId);
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
    _lifeAreasMap.putIfAbsent(value, () => true);
    _textController.clear();
    setState(() {});
  }

  _switchChecked(String title){
    _lifeAreasMap.forEach((key, value) {
      if(key == title){
        _lifeAreasMap.update(key, (value) => value ? false : true);
      }
    });
    setState(() {

    });
  }


  void _next(BuildContext context, int assessmentId){
    int noLifeAreas = 0;
    String lifeAreas = "";

    //put each key (lifeArea) in a comma separated string
    //and count number of life areas
    _lifeAreasMap.forEach((key, value) {
      if(value) {
        print(key);
        noLifeAreas++;
        lifeAreas += key+", ";
      }
    });
    print(lifeAreas);

    //create network card
    final NetworkCard newNetworkCard = new NetworkCard(null, assessmentId, noLifeAreas, lifeAreas);

    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;
    assessmentRepo.createNetworkCard(newNetworkCard).then((networkId){
      print(newNetworkCard.toString());
      print(networkId);
      Navigator.of(context).pushNamed('/importantPersons', arguments: assessmentId);
    });

    //reset variables
    noLifeAreas = 0;
    lifeAreas = "";
  }




}