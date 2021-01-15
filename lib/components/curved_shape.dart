import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


// this is a curved shape created for the start screen of the assessment.
// the shape needs to be set in a Container widget,
// which has to fill the full size (width and height) of the device (e.g using MediaQueries).
// therefore the container needs to be in a Stack widget

// the curved shape takes 100% of the screens width
// and 25% of the screens height

// the constructor takes a start and an end color for the bg gradient
// beginning from bottom to top

class CurvedShape extends CustomPainter{
  final Color startColor;
  final Color endColor;

  CurvedShape(this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.shader = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      stops: [
        0.24,
        1
      ],
      colors: [
        startColor,
        endColor,
      ],
    ).createShader(
      Offset.zero & size
    );

    var path = Path();

    path.moveTo(0, size.height * 0.2);
    path.quadraticBezierTo(
        size.width / 2, size.height*0.3, size.width, size.height * 0.2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}