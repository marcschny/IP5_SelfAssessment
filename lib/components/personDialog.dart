import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/networdcard.dart';
import 'package:ip5_selbsteinschaetzung/themes/sa_sr_theme.dart';
import 'package:flutter_score_slider/flutter_score_slider.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart';



class PersonDialog extends StatefulWidget{

  final int assessmentId;
  final int networkId;


  const PersonDialog({
    Key key,
    this.assessmentId,
    this.networkId
  }) : super(key: key);


  _PersonDialogState createState() => _PersonDialogState();

}

class _PersonDialogState extends State<PersonDialog>{

  final _nameController = TextEditingController();

  String lifeAreasString;

  List<String> _lifeAreas;
  String _selectedLifeArea;

  int _currentDistance = 5;


  String _selectedIcon;
  bool _showAdditionalCategories = false;

  List<DropdownMenuItem<String>> _dropdownMenuItems;

  Map<int, String> _distanceMap = {
    0: "Gar nicht nah",
    1: "Weniger nah",
    2: "Weniger nah",
    3: "Weniger nah",
    4: "Nah",
    5: "Nah",
    6: "Nah",
    7: "Sehr nah",
    8: "Sehr nah",
    9: "Sehr nah",
    10: "Sehr sehr nah",
  };

  @override
  void initState() {
    super.initState();
    _dropdownMenuItems = List();
    _lifeAreas = List();
    _selectedLifeArea = "";
    _getLifeAreas();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }


  onChangeDropdownItem(String value) {
    setState(() {
      _selectedLifeArea = value;
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Person hinzufügen",
                  style: ThemeTexts.assessmentDialogTitle,
                  overflow: TextOverflow.clip,
                ),
              ),


              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                margin: EdgeInsets.only(bottom: 20),
                child: TextField(
                  maxLines: 1,
                  controller: _nameController,
                  onSubmitted: (value){

                  },
                  textInputAction: TextInputAction.go,
                  decoration: InputDecoration(
                    hintText: "Name der Person...",
                    hintStyle: ThemeTexts.assessmentText.copyWith(fontSize: 20, color: Colors.grey),
                    contentPadding: EdgeInsets.all(0),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ThemeColors.greenShade3),
                    ),
                  ),
                  style: ThemeTexts.assessmentText.copyWith(fontSize: 20),
                ),
              ),


              Container(
                padding: EdgeInsets.symmetric(vertical: 28, horizontal: 18),
                child: Column(
                  children: [
                    Text(
                      "Wähle ein Icon",
                      style: ThemeTexts.assessmentDialogSubtitle,
                      overflow: TextOverflow.clip,
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              OutlineButton(
                                onPressed: (){
                                  setState(() {
                                    _selectedIcon = "Erwachsener";
                                  });
                                },
                                color: Colors.transparent,
                                highlightColor: ThemeColors.greenShade3,
                                highlightedBorderColor: ThemeColors.greenShade2,
                                padding: EdgeInsets.all(10),
                                shape: CircleBorder(),
                                borderSide: BorderSide(
                                    color: _selectedIcon == "Erwachsener" ? ThemeColors.greenShade2 : Colors.transparent,
                                    width: _selectedIcon == "Erwachsener" ? 1.5 : 0,
                                ),
                                child: Icon(
                                  Icons.person,
                                  size: 30,
                                  color: Color.fromRGBO(80, 80, 80, 1),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Erwachsener",
                                style: ThemeTexts.assessmentNavigationNext.copyWith(fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              OutlineButton(
                                onPressed: (){
                                  setState(() {
                                    _selectedIcon = "Gleichaltrige";
                                  });
                                },
                                color: Colors.transparent,
                                highlightColor: ThemeColors.greenShade3,
                                highlightedBorderColor: ThemeColors.greenShade2,
                                padding: EdgeInsets.all(10),
                                shape: CircleBorder(),
                                borderSide: BorderSide(
                                  color: _selectedIcon == "Gleichaltrige" ? ThemeColors.greenShade2 : Colors.transparent,
                                  width: _selectedIcon == "Gleichaltrige" ? 1.5 : 0,
                                ),
                                child: Icon(
                                  Icons.person,
                                  size: 30,
                                  color: Color.fromRGBO(80, 80, 80, 1),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Gleichaltrige",
                                style: ThemeTexts.assessmentNavigationNext.copyWith(fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              OutlineButton(
                                onPressed: (){
                                  setState(() {
                                    _showAdditionalCategories = !_showAdditionalCategories;
                                  });
                                },
                                color: Colors.transparent,
                                padding: EdgeInsets.all(10),
                                shape: CircleBorder(),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 0,
                                ),
                                child: Icon(
                                  Icons.arrow_downward_rounded,
                                  size: 30,
                                  color: ThemeColors.greenShade2,
                                ),
                              ),
                              SizedBox(height: 0),
                              Text(
                                "Andere\nKategorien",
                                style: ThemeTexts.assessmentNavigationNext.copyWith(fontWeight: FontWeight.w400, color: ThemeColors.greenShade2),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      )
                    ),

                    Visibility(
                      visible: _showAdditionalCategories,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  OutlineButton(
                                    onPressed: (){
                                      setState(() {
                                        _selectedIcon = "Verstorbene";
                                      });
                                    },
                                    color: Colors.transparent,
                                    highlightColor: ThemeColors.greenShade3,
                                    highlightedBorderColor: ThemeColors.greenShade2,
                                    padding: EdgeInsets.all(10),
                                    shape: CircleBorder(),
                                    borderSide: BorderSide(
                                      color: _selectedIcon == "Verstorbene" ? ThemeColors.greenShade2 : Colors.transparent,
                                      width: _selectedIcon == "Verstorbene" ? 1.5 : 0,
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      size: 30,
                                      color: Color.fromRGBO(80, 80, 80, 1),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Verstorbene",
                                    style: ThemeTexts.assessmentNavigationNext.copyWith(fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  OutlineButton(
                                    onPressed: (){
                                      setState(() {
                                        _selectedIcon = "Tiere";
                                      });
                                    },
                                    color: Colors.transparent,
                                    highlightColor: ThemeColors.greenShade3,
                                    highlightedBorderColor: ThemeColors.greenShade2,
                                    padding: EdgeInsets.all(10),
                                    shape: CircleBorder(),
                                    borderSide: BorderSide(
                                      color: _selectedIcon == "Tiere" ? ThemeColors.greenShade2 : Colors.transparent,
                                      width: _selectedIcon == "Tiere" ? 1.5 : 0,
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      size: 30,
                                      color: Color.fromRGBO(80, 80, 80, 1),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Tiere",
                                    style: ThemeTexts.assessmentNavigationNext.copyWith(fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  OutlineButton(
                                    onPressed: (){
                                      setState(() {
                                        _selectedIcon = "Kinder";
                                      });
                                    },
                                    color: Colors.transparent,
                                    highlightColor: ThemeColors.greenShade3,
                                    highlightedBorderColor: ThemeColors.greenShade2,
                                    padding: EdgeInsets.all(10),
                                    shape: CircleBorder(),
                                    borderSide: BorderSide(
                                      color: _selectedIcon == "Kinder" ? ThemeColors.greenShade2 : Colors.transparent,
                                      width: _selectedIcon == "Kinder" ? 1.5 : 0,
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      size: 30,
                                      color: Color.fromRGBO(80, 80, 80, 1),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Kinder",
                                    style: ThemeTexts.assessmentNavigationNext.copyWith(fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),

                            ],
                          )
                      ),
                    ),
                  ],
                ),
              ),


            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Wähle den zugehörigen Lebensbereich",
                    style: ThemeTexts.assessmentDialogSubtitle,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  _selectedLifeArea.isEmpty ?
                  DropdownButton(
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down_rounded),
                    iconSize: 32,
                    hint: Text("Lebensbereich auswählen", style: ThemeTexts.assessmentText.copyWith(color: Color.fromRGBO(180, 180, 180, 1), fontWeight: FontWeight.w400)),
                    items: _dropdownMenuItems,
                    onChanged: onChangeDropdownItem,
                  ) :
                  DropdownButton(
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down_rounded),
                    iconSize: 32,
                    hint: Text("Lebensbereich auswählen", style: ThemeTexts.assessmentText.copyWith(color: Color.fromRGBO(180, 180, 180, 1), fontWeight: FontWeight.w400)),
                    value: _selectedLifeArea,
                    items: _dropdownMenuItems,
                    onChanged: onChangeDropdownItem,
                  ),

                ],
              ),
            ),


              Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Wie nahe ist Dir diese Person?",
                      style: ThemeTexts.assessmentDialogSubtitle,
                      overflow: TextOverflow.clip,
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Ziehe den Kreis nach links oder rechts",
                      style: ThemeTexts.assessmentText.copyWith(fontSize: 14, color: Color.fromRGBO(200, 200, 200, 1)),
                      overflow: TextOverflow.clip,
                    ),
                    SizedBox(height: 14),
                    ScoreSlider(
                      maxScore: 10,
                      score: 5,
                      onScoreChanged: (newDistance){
                        setState(() {
                          _currentDistance = newDistance;
                        });
                      },
                      backgroundColor: Colors.transparent,
                      scoreDotColor: ThemeColors.greenShade3,
                      thumbColor: ThemeColors.greenShade2,
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Nähe: "+_distanceMap[_currentDistance],
                      style: ThemeTexts.assessmentText.copyWith(fontSize: 14, color: Color.fromRGBO(110, 110, 110, 1), fontWeight: FontWeight.w500),
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),


              SizedBox(height: 120),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width-32,
        color: Colors.transparent,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            ButtonTheme(
            height: 51,
            minWidth: 51,
            child: RaisedButton(
              elevation: 0.0,
              color: ThemeColors.greyShade1,
              shape: CircleBorder(),
              child: Icon(
                Icons.close,
                color: Color.fromRGBO(80, 80, 80, 1),
              ),
              onPressed: (){

              },
            ),
          ),

            ButtonTheme(
              height: 56,
              minWidth: 66,
              child: RaisedButton(
                elevation: 0.0,
                color: ThemeColors.greenShade2,
                shape: CircleBorder(),
                child: Icon(
                  Icons.check,
                  color: Color.fromRGBO(80, 80, 80, 1),
                ),
                onPressed: (){
                    //todo: validate inputs
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getLifeAreas() async{
    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;
    final NetworkCard networkCard = await assessmentRepo.findNetworkCard(widget.assessmentId);
    print("areas: "+networkCard.lifeAreas);
    setState(() {
      _lifeAreas = networkCard.lifeAreas.split(",").map((e) => e.trim()).toList();
    });
    _lifeAreas.forEach((element) {
      if(element != null && element != "") {
        _dropdownMenuItems.add(
            DropdownMenuItem(
              value: element,
              child: Text(element),
            )
        );
      }
    });
  }

}