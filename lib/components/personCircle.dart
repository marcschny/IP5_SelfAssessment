import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_tooltip/super_tooltip.dart';


class PersonCircle extends StatefulWidget {

  //todo: person in constructor instead of these variables
  final String icon;
  final String name;

  const PersonCircle({
    Key key,
    this.icon,
    this.name
  });

  _PersonCircleState createState() => _PersonCircleState();

}

class _PersonCircleState extends State<PersonCircle>{

  SuperTooltip tooltip;




  void _onTap() {
    tooltip = SuperTooltip(
      popupDirection: TooltipDirection.down,
      hasShadow: false,
      arrowLength: 14,
      arrowTipDistance: 12,
      maxWidth: MediaQuery.of(context).size.width-120,
      outsideBackgroundColor: Colors.transparent,
      backgroundColor: Color.fromRGBO(80, 80, 80, 1),
      borderColor: Color.fromRGBO(80, 80, 80, 1),
      content: new Material(
        color: Color.fromRGBO(80, 80, 80, 1),
        child: Text(
          widget.name,
          style: TextStyle(
            fontSize: 13,
            color: Colors.white,
          ),
          softWrap: true,
          textAlign: TextAlign.center,
        ),
      ),
    );
    tooltip.show(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Color.fromRGBO(80, 80, 80, 1),
            width: 1
          ),
        ),
        child: Icon(
          Icons.person,
          size: 30,
          color: Color.fromRGBO(80, 80, 80, 1)
        ),
      ),
      onTap: _onTap,
    );
  }



}