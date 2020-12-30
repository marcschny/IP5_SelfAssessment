import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/components/bottom_navigation.dart';
import 'package:ip5_selbsteinschaetzung/components/checkbox_component.dart';
import 'package:ip5_selbsteinschaetzung/components/top_bar.dart';
import 'package:ip5_selbsteinschaetzung/database/database.dart';
import 'package:ip5_selbsteinschaetzung/database/entities/visualization.dart';
import 'package:ip5_selbsteinschaetzung/resources/animations/fade_in.dart';
import 'package:ip5_selbsteinschaetzung/screens/important_persons.dart';
import 'package:ip5_selbsteinschaetzung/themes/assessment_theme.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';


//Screen 1.1
class LifeAreas extends StatefulWidget{

  final int assessmentId;
  final int visualizationId;

  const LifeAreas({
    Key key,
    @required this.assessmentId,
    @required this.visualizationId,
  });

  _LifeAreasState createState() => _LifeAreasState();

}

class _LifeAreasState extends State<LifeAreas>{

  //key for animatedList
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();


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
    return WillPopScope(
      onWillPop: (){},
      child: Scaffold(
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
                    subtitle: "Bereiche",
                    percent: 0.05,
                    intro: "Um Deine Visualisierung erstellen zu können musst Du zuerst auswählen welche Bereiche Dir momentan wichtig sind: Welches sind für Dich wichtige Bereiche? ",
                    showProgressbar: true,
                  ),

                  FadeIn(
                    1.5,
                    500,
                    _customCheckBox(),
                  ),


                  Expanded(
                    child: FadeIn(
                      1.6,
                      500,
                      Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 94),
                        child: AnimatedList(
                          key: _listKey,
                          initialItemCount: _lifeAreasMap.length,
                          itemBuilder: (context, index, animation){
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, -1),
                                end: Offset(0, 0),
                              ).animate(animation),
                              child: CheckBoxComponent(
                                checkboxTitle: _lifeAreasMap.keys.elementAt(_lifeAreasMap.length-index-1), //count backwards, so the newly added life area appears on top
                                checked: _lifeAreasMap.values.elementAt(_lifeAreasMap.length-index-1),
                                callback: (checkBoxTitle){
                                  _switchChecked(checkBoxTitle);
                                }
                              ),
                            );
                          },
                        ),
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
                  _next(context);
                },
              ),
            ],
          ),
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
                onChanged: (value){},
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
                    hintText: "Bereich hinzufügen...",
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
    if(value.length > 2) {
      _listKey.currentState.insertItem(0, duration: const Duration(milliseconds: 200));
      _lifeAreasMap.putIfAbsent(value, () => true);
      _textController.clear();
      //setState(() {});
    }
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
  void _next(BuildContext context) async{
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
      final appDatabase = Provider.of<AppDatabase>(context, listen: false);
      final assessmentRepo = appDatabase.assessmentRepository;

      final Visualization updatedVisualization = Visualization(widget.visualizationId, widget.assessmentId, noLifeAreas, lifeAreas);

      assessmentRepo.updateVisualization(updatedVisualization);
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 300),
          pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return ImportantPersons(assessmentId: widget.assessmentId, visualizationId: widget.visualizationId);
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