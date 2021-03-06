import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ip5_selbsteinschaetzung/themes/assessment_theme.dart';

//this is the custom component for the wheel painter (visualization)
class WheelPainter extends CustomPainter {

  final int noAreas;
  final double widgetSize;


  const WheelPainter({
    Key key,
    this.noAreas,
    this.widgetSize
  });



  Path getWheelPath(double wheelSize, double fromRadius, double toRadius) {
    return new Path()
      ..moveTo(wheelSize, wheelSize)
      ..arcTo(Rect.fromCircle(radius: wheelSize, center: Offset(wheelSize, wheelSize)), fromRadius, toRadius, false)
      ..close();
  }

  Paint getColoredPaint(Color color) {
    Paint paint = Paint();
    paint.color = color;
    return paint;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double wheelSize = widgetSize/2;
    int noElements = noAreas;
    double radius = (2 * pi) / noElements;

    //paints circle with only one sector
    var paintFullCircle = Paint()
      ..color = ThemeColors.firstColor
      ..style = PaintingStyle.fill;

    //draw circle with different sectors
    if(noElements == 1){
      canvas.drawCircle(Offset(wheelSize, wheelSize), wheelSize, paintFullCircle);
    }
    canvas.drawPath(getWheelPath(wheelSize, 0, radius), getColoredPaint(ThemeColors.sixthColor));
    canvas.drawPath(getWheelPath(wheelSize, radius, radius), getColoredPaint(ThemeColors.fifthColor));
    canvas.drawPath(getWheelPath(wheelSize, radius * 2, radius), getColoredPaint(ThemeColors.fourthColor));
    canvas.drawPath(getWheelPath(wheelSize, radius * 3, radius), getColoredPaint(ThemeColors.thirdColor));
    canvas.drawPath(getWheelPath(wheelSize, radius * 4, radius), getColoredPaint(ThemeColors.secondColor));
    canvas.drawPath(getWheelPath(wheelSize, radius * 5, radius), getColoredPaint(ThemeColors.firstColor));


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}