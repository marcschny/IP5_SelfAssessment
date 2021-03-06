import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/person.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/visualization.dart';
import 'package:ip5_selbsteinschaetzung/components/animations/fade_in.dart';
import 'package:ip5_selbsteinschaetzung/themes/assessment_theme.dart';
import 'package:flutter_score_slider/flutter_score_slider.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';


//this is the person dialog used in important_persons (part_1)
//this dialog creates a person
class PersonDialog extends StatefulWidget{

  final int assessmentId;
  final int visualizationId;
  final Person person;

  const PersonDialog({
    Key key,
    @required this.assessmentId,
    @required this.visualizationId,
    this.person
  }) : super(key: key);


  _PersonDialogState createState() => _PersonDialogState();

}

class _PersonDialogState extends State<PersonDialog>{

  //define TextEditingController for the name input
  final _nameController = TextEditingController();

  //variables used for the category selection
  String _selectedIcon;
  bool _showAdditionalCategories = false;

  //variables and methods for the area selection
  List<String> _lifeAreas;
  String _selectedLifeArea;
  List<DropdownMenuItem<String>> _dropdownMenuItems;

  onChangeDropdownItem(String value) {
    setState(() {
      _selectedLifeArea = value;
    });
  }


  //define default distance
  int _currentDistance = 4;
  //Map with distance value and related text
  Map<int, String> _distanceMap = {
    8: "Sehr sehr wichtig",
    7: "Sehr wichtig" ,
    6: "Sehr wichtig",
    5: "Wichtig",
    4: "Wichtig",
    3: "Etwas wichtig" ,
    2: "Weniger wichtig",
    1: "Weniger wichtig",
    0: "Gar nicht wichtig"
  };




  @override
  void initState() {
    super.initState();
    _dropdownMenuItems = List();
    _lifeAreas = List();
    _selectedLifeArea = "";
    _selectedIcon = "";
    _nameController.clear();
    _getLifeAreas();
    _checkForUpdatePerson();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  //this methods checks if a new person has to be created
  //or if a person has to be updated
  _checkForUpdatePerson() async{
    if(widget.person != null){
      setState(() {
        _nameController.text = widget.person.name;
        _selectedIcon = widget.person.icon;
        _selectedLifeArea = widget.person.lifeArea;
        _currentDistance = 8-widget.person.distance.toInt();
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeIn(
        1.34,
        500,
        Padding(
          padding: EdgeInsets.only(bottom: 94),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 22),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  //title
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 14),
                    child: Text(
                      "Person hinzuf??gen",
                      style: ThemeTexts.assessmentDialogTitle,
                      overflow: TextOverflow.clip,
                    ),
                  ),

                  //textfield for name input
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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

                  //icons for category
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 28, horizontal: MediaQuery.of(context).size.width > 600 ? 18 : 6),
                    child: Column(
                      children: [
                        Text(
                          "W??hle eine Kategorie",
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
                                        _selectedIcon = "Erwachsene";
                                      });
                                    },
                                    color: Colors.transparent,
                                    highlightColor: ThemeColors.greenShade3,
                                    highlightedBorderColor: ThemeColors.greenShade2,
                                    padding: EdgeInsets.all(10),
                                    shape: CircleBorder(),
                                    borderSide: BorderSide(
                                        color: _selectedIcon == "Erwachsene" ? ThemeColors.greenShade2 : Colors.transparent,
                                        width: _selectedIcon == "Erwachsene" ? 1.5 : 0,
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      size: 30,
                                      color: Color.fromRGBO(80, 80, 80, 1),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Erwachsene",
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
                                    "Weitere\nKategorien",
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

                //dropdown list for areas
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "W??hle den zugeh??rigen Bereich",
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
                        hint: Text("Bereich ausw??hlen", style: ThemeTexts.assessmentText.copyWith(color: Color.fromRGBO(180, 180, 180, 1), fontWeight: FontWeight.w400)),
                        items: _dropdownMenuItems,
                        onChanged: onChangeDropdownItem,
                      ) :
                      DropdownButton(
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down_rounded),
                        iconSize: 32,
                        hint: Text("Bereich ausw??hlen", style: ThemeTexts.assessmentText.copyWith(color: Color.fromRGBO(180, 180, 180, 1), fontWeight: FontWeight.w400)),
                        value: _selectedLifeArea,
                        items: _dropdownMenuItems,
                        onChanged: onChangeDropdownItem,
                      ),

                    ],
                  ),
                ),

                  //slider for distance
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Wie wichtig ist Dir diese Person?",
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
                          maxScore: 8,
                          score: _currentDistance,
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
                          "Wichtigkeit: "+_distanceMap[_currentDistance],
                          style: ThemeTexts.assessmentText.copyWith(fontSize: 14, color: Color.fromRGBO(110, 110, 110, 1), fontWeight: FontWeight.w500),
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                Navigator.of(context).pop();
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
                    if(!_validate()){

                      showToast(
                        _missingInput(),
                        context: context,
                      );
                    }else{

                      //write new person to db

                      //create new person
                      final Person newPerson = new Person(
                        widget.person != null ? widget.person.id : null,  //id when update, null when create
                        _nameController.text,
                        _selectedIcon,
                        _selectedLifeArea,
                        (8 - _currentDistance).toDouble(),
                        widget.visualizationId,
                        widget.assessmentId
                      );


                      final appDatabase = Provider.of<AppDatabase>(context, listen: false);
                      final assessmentRepo = appDatabase.assessmentRepository;

                      //create new person
                      if(widget.person == null) {
                        assessmentRepo.createPerson(newPerson).then((personId) {
                          Navigator.of(context).pop();
                        });
                      }
                      //update person
                      else{
                        assessmentRepo.updatePerson(newPerson).then((personId){
                          Navigator.of(context).pop();
                        });
                      }
                    }
                },
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  //fetches all areas from the db and creates dropdown menu items for each area
  _getLifeAreas() async{
    //initialize app db
    final appDatabase = Provider.of<AppDatabase>(context, listen: false);
    final assessmentRepo = appDatabase.assessmentRepository;

    //get visualization by assessment id
    final Visualization visualization = await assessmentRepo.findVisualization(widget.assessmentId);

    //convert life areas from comma separated string to list
    setState(() {
      _lifeAreas = visualization.lifeAreas.split(",").map((e) => e.trim()).toList();
    });

    //create a dropdownmenuitem for each life area string
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

  //check for missing inputs return bool
  bool _validate(){
    if(_nameController.text != "" && _selectedIcon != "" && _selectedLifeArea != "" && _currentDistance != null) return true;
    else return false;
  }

  //return missing input toast text
  String _missingInput(){
    if(_nameController.text == ""){
      return "Gib der Person einen Namen";
    }else if(_selectedIcon == ""){
      return "W??hle eine Kategorie";
    }else if(_selectedLifeArea == ""){
      return "W??hle einen Bereich";
    }else{
      return "";
    }
  }

}