import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


//theming for Short Assessment "Social Relationships"
abstract class ThemeColors{
  //main colors - primary green shades
  static const Color greenShade0 = Color.fromRGBO(37, 54, 41, 1);
  static const Color greenShade1 = Color.fromRGBO(73, 101, 77, 1);
  static const Color greenShade2 = Color.fromRGBO(139, 169, 137, 1);
  static const Color greenShade3 = Color.fromRGBO(192, 207, 178, 1);
  static const Color greenShade4 = Color.fromRGBO(228, 230, 218, 1);
  //main colors - grey shades
  static const Color greyShade0 = Color.fromRGBO(170, 170, 170, 1);   //title color
  static const Color greyShade1 = Color.fromRGBO(229, 229, 229, 1);   //back button color
}

abstract class ThemeTexts{

  /* 0 Start Screen */

  static TextStyle startAssessmentTitle = GoogleFonts.raleway(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: Colors.black
  );

  static TextStyle startAssessmentSubtitle = GoogleFonts.raleway(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: Colors.black
  );



  /* Assessment Screens */

  //assessment big number title
  static TextStyle assessmentNumberTitle = GoogleFonts.quicksand(
    fontSize: 40,
    color: Color.fromRGBO(73, 101, 77, 1),
  );


  //assessment title
  static TextStyle assessmentTitle = GoogleFonts.roboto(
    fontSize: 17,
    color: Color.fromRGBO(73, 101, 77, 1),
    fontWeight: FontWeight.w500
  );


  //assessment subtitle
  static TextStyle assessmentSubtitle = GoogleFonts.roboto(
    fontSize: 20.5,
    color: Color.fromRGBO(170, 170, 170, 1),
    fontWeight: FontWeight.w500
  );


  //assessment intro text
  static TextStyle assessmentIntro = GoogleFonts.roboto(
    fontSize: 14.5,
    color: Colors.black,
    fontWeight: FontWeight.w400
  );


  //navigation text "Weiter zu ..." (only bottom part - top part needs to be thicker)
  static TextStyle assessmentNavigationNext = GoogleFonts.roboto(
    fontSize: 13.5,
    color: Colors.black,
    fontWeight: FontWeight.w300
  );


  //questions
  static TextStyle assessmentQuestion = GoogleFonts.roboto(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w400
  );


  //subquestions or radio button answers
  static TextStyle assessmentSubquestion = GoogleFonts.roboto(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w300
  );

  //answers
  static TextStyle assessmentAnswer = GoogleFonts.roboto(
    fontSize: 16.5,
    color: Colors.black,
    fontWeight: FontWeight.w300
  );


  //dialog box titles
  static TextStyle assessmentDialogTitle = GoogleFonts.roboto(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w500
  );


  //dialog box subtitles
  static TextStyle assessmentDialogSubtitle = GoogleFonts.roboto(
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w500
  );


  //dialog box subtitles
  static TextStyle assessmentText = GoogleFonts.roboto(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.w400
  );




}