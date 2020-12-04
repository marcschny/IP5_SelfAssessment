import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';


enum AniProps {opacity, translateY}

class SlideUpFadeIn extends StatelessWidget {
  final double delay;
  final Widget child;

  SlideUpFadeIn(this.delay, this.child);


  @override
  Widget build(BuildContext context) {
    final _tween = MultiTween<AniProps>()
      ..add(AniProps.opacity, Tween(begin: 0.0, end: 1.0), Duration(milliseconds: 500))
      ..add(AniProps.translateY, Tween(begin: 130.0, end: 0.0), Duration(milliseconds: 400));



    return PlayAnimation<MultiTweenValues<AniProps>>(
      delay: Duration(milliseconds: (300 * delay).round()),
      duration: _tween.duration,
      tween: _tween,
      child: child,
      builder: (context, child, animation) => Opacity(
        opacity: animation.get(AniProps.opacity),
        child: Transform.translate(
            offset: Offset(0, animation.get(AniProps.translateY)), child: child),
      ),
    );
  }
}