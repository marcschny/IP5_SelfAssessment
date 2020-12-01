import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/BottomNavigation.dart';
import 'package:ip5_selbsteinschaetzung/components/CheckBoxComponent.dart';
import 'package:ip5_selbsteinschaetzung/components/topBar.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/networkcard.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';



//Screen 1.1
class LifeAreas extends StatefulWidget{

  const LifeAreas({Key key});

  _LifeAreasState createState() => _LifeAreasState();

}

class _LifeAreasState extends State<LifeAreas>{


  bool alreadyExists = false; //check if network card already exists (for navigator.pop)
  int netwId = -1;  //will be reset when new network card is created

  //update variable 'alreadyExists' when navigator popped
  void updateAlreadyExists(bool boolValue){
    setState(() {
      alreadyExists = boolValue;
    });
  }

  TextEditingController _textController = TextEditingController();


  Map<String, bool> _lifeAreasMap = {
    "Verein / Hobby": false,
    "Schule / Ausbildung / Arbeit": false,
    "Sozialpädagog*innen im Heim/WG": false,
    "Freund*innen ausserhalb": false,
    "Freund*innen im Heim/WG": false,
    "Familie": false,
  };


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
    final int assessmentId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  title: "Wer ist mir wichtig?\nMeine wichtigen Personen",
                  titleNumber: 1,
                  onClose: null,
                  subtitle: "Bereiche",
                  percent: 0.05,
                  intro: "Um deine Karte zu erstellen musst Du zuerst auswählen, welche Bereiche Dir momentan wichtig sind: Welches sind für Dich wichtige Bereiche? ",
                ),

                _customCheckBox(),

                Expanded(
                  child: Container(
                    color: Colors.transparent,
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
                  textInputAction: TextInputAction.go,
                  decoration: InputDecoration(
                    hintText: "Neuer Bereich hinzufügen...",
                    hintStyle: ThemeTexts.assessmentText.copyWith(fontSize: 18, color: Colors.grey),
                    contentPadding: EdgeInsets.only(bottom: 0),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ThemeColors.greenShade3),
                    ),
                  ),
                  style: ThemeTexts.assessmentText,
                ),
              )
            ]
        )
    );
  }

  //when textfield is submitted
  _onSubmit(String value){
    print(value);
    if(value.length > 2) _lifeAreasMap.putIfAbsent(value, () => true);
    _textController.clear();
    setState(() {});
  }

  //switch checkbox state
  _switchChecked(String title){
    _lifeAreasMap.forEach((key, value) {
      if(key == title){
        _lifeAreasMap.update(key, (value) => value ? false : true);
      }
    });
    setState(() { });
  }


  //next page
  void _next(BuildContext context, int assessmentId) async{
    int noLifeAreas = 0;
    String lifeAreas = "";

    //put each key (lifeArea) in a comma separated string
    //and count number of life areas
    _lifeAreasMap.forEach((key, value) {
      if (value) {
        print(key);
        noLifeAreas++;
        lifeAreas += key + ", ";
      }
    });

    //only continue when number of lifeareas is bigger than 1 and smaller than 7
    if (noLifeAreas > 0 && noLifeAreas <= 6) {
      //create network card
      final NetworkCard newNetworkCard = new NetworkCard(
          !alreadyExists ? null : netwId, assessmentId, noLifeAreas, lifeAreas); //if already exists set current network id, else null (auto increment)


      print("already exists: "+alreadyExists.toString());

      final appDatabase = Provider.of<AppDatabase>(context, listen: false);
      final assessmentRepo = appDatabase.assessmentRepository;

      //if record does not already exist
      if(!alreadyExists) {
        assessmentRepo.createNetworkCard(newNetworkCard).then((
            networkId) async {
          final boolValue = await Navigator.of(context).pushNamed(
            '/importantPersons',
            arguments: <String, int>{
              "assessmentId": assessmentId,
              "networkId": networkId
            },
          );
          updateAlreadyExists(boolValue);
          setState(() {
            netwId = networkId;
          });
        });

        //reset variables
        noLifeAreas = 0;
        lifeAreas = "";
      }
      //if record already exists -> update it
      else{
        assessmentRepo.updateNetworkCard(newNetworkCard);
          Navigator.of(context).pushNamed(
            '/importantPersons',
            arguments: <String, int>{
              "assessmentId": assessmentId,
              "networkId": netwId
            },
          );
      }
    }else{
      showToast(
        "Wähle mindestens einen Bereich",
        context: context,
        textAlign: TextAlign.center,
        textStyle: ThemeTexts.toastText,
        textPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        position: ToastPosition.bottom,
        backgroundColor: Color.fromRGBO(70, 70, 70, .7),
        duration: Duration(milliseconds: 2500),
      );
    }

  }

}