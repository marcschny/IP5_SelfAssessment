import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

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

    canvas.drawPath(getWheelPath(wheelSize, 0, radius), getColoredPaint(Color.fromRGBO(222, 206, 206, 1)));
    canvas.drawPath(getWheelPath(wheelSize, radius, radius), getColoredPaint(Color.fromRGBO(216, 222, 206, 1)));
    canvas.drawPath(getWheelPath(wheelSize, radius * 2, radius), getColoredPaint(Color.fromRGBO(206, 222, 214, 1)));
    canvas.drawPath(getWheelPath(wheelSize, radius * 3, radius), getColoredPaint(Color.fromRGBO(206, 219, 222, 1)));
    canvas.drawPath(getWheelPath(wheelSize, radius * 4, radius), getColoredPaint(Color.fromRGBO(212, 206, 222, 1)));
    canvas.drawPath(getWheelPath(wheelSize, radius * 5, radius), getColoredPaint(Color.fromRGBO(222, 206, 220, 1)));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}