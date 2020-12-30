import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';


enum AniProps {translateX}

class SlideLeft extends StatelessWidget{
  final double delay;
  final Widget child;

  SlideLeft(this.delay, this.child);


  @override
  Widget build(BuildContext context) {
    final _tween = MultiTween<AniProps>()
      ..add(AniProps.translateX, Tween(begin: MediaQuery.of(context).size.width, end: 0.0), Duration(milliseconds: 120));

    return PlayAnimation<MultiTweenValues<AniProps>>(
      delay: Duration(milliseconds: (300 * delay).round()),
      duration: _tween.duration,
      tween: _tween,
      curve: Curves.linear,
      child: child,
      builder: (context, child, animation) => (
          Transform.translate(
            offset: Offset(animation.get(AniProps.translateX), 0),
            child: child,
          )),

    );

  }

}