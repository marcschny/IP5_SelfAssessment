import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_tooltip/super_tooltip.dart';


class InfoButton extends StatefulWidget {

  final String text;
  final TooltipDirection tooltipDirection;

  const InfoButton({
    Key key,
    this.text,
    this.tooltipDirection
  });

  _InfoButtonState createState() => _InfoButtonState();

}

class _InfoButtonState extends State<InfoButton>{

  SuperTooltip tooltip;

  void _onTap() {
    tooltip = SuperTooltip(
      popupDirection: widget.tooltipDirection,
      hasShadow: false,
      arrowLength: 12,
      arrowTipDistance: 10,
      maxWidth: MediaQuery.of(context).size.width-80,
      outsideBackgroundColor: Colors.transparent,
      backgroundColor: Color.fromRGBO(225, 225, 225, .9),
      borderColor: Colors.transparent,
      content: new Material(
        color: Color.fromRGBO(225, 225, 225, .9),
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: 13,
            color: Colors.black45,
          ),
          softWrap: true,
          textAlign: TextAlign.start,
        ),
      ),
    );
    tooltip.show(context);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.info_rounded, size: 26.5, color: Color.fromRGBO(210, 210, 210, 1)),
      onPressed: _onTap,
    );
  }



}