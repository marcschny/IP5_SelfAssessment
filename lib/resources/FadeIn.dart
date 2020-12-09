import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';


enum AniProps {opacity}

class FadeIn extends StatelessWidget {
  final double delay;
  final int duration;
  final Widget child;

  FadeIn(this.delay, this.duration, this.child);


  @override
  Widget build(BuildContext context) {
    final _tween = MultiTween<AniProps>()
      ..add(AniProps.opacity, Tween(begin: 0.0, end: 1.0), Duration(milliseconds: duration));



    return PlayAnimation<MultiTweenValues<AniProps>>(
      delay: Duration(milliseconds: (300 * delay).round()),
      duration: _tween.duration,
      tween: _tween,
      child: child,
      curve: Curves.ease,
      builder: (context, child, animation) => Opacity(
        opacity: animation.get(AniProps.opacity),
        child: child
      ),
    );
  }
}