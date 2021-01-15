import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';


enum AniProps {translateY}

//this animation component creates a slide-up-from-bottom-animation
class SlideUpFromBottom extends StatelessWidget {
  final double delay;
  final Widget child;

  SlideUpFromBottom(this.delay, this.child);


  @override
  Widget build(BuildContext context) {
    final _tween = MultiTween<AniProps>()
      ..add(AniProps.translateY, Tween(begin: MediaQuery.of(context).size.height, end: 0.0), Duration(milliseconds: 320));

    return PlayAnimation<MultiTweenValues<AniProps>>(
      delay: Duration(milliseconds: (300 * delay).round()),
      duration: _tween.duration,
      tween: _tween,
      curve: Curves.easeInOutQuart,
      child: child,
      builder: (context, child, animation) => (
          Transform.translate(
            offset: Offset(0, animation.get(AniProps.translateY)),
            child: child,
          )),

      );

  }
}