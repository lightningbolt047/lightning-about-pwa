import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class LanguageIconIndicator extends StatefulWidget {
  final Color color;
  final String text;
  final IconData? iconData;
  final String iconifyString;
  final bool logoMultiColor;
  const LanguageIconIndicator({Key? key,this.color=Colors.blue,this.iconData,required this.text,this.iconifyString="",this.logoMultiColor=false}) : super(key: key);

  @override
  State<LanguageIconIndicator> createState() => _LanguageIconIndicatorState(color,iconData,text,iconifyString,logoMultiColor);
}

class _LanguageIconIndicatorState extends State<LanguageIconIndicator> {
  final Color color;
  final String text;
  final IconData? iconData;
  final String iconifyString;
  final bool logoMultiColor;

  _LanguageIconIndicatorState(this.color,this.iconData,this.text,this.iconifyString,this.logoMultiColor);

  bool _mouseInside=false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (pointerEvent){
        setState((){
          _mouseInside=true;
        });
      },
      onExit: (pointerEvent){
        setState((){
          _mouseInside=false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        margin: EdgeInsets.all(4),
        height: 65,
        width: 65,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: color
            ),
          color: _mouseInside?color:Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(iconData==null)
                Iconify(iconifyString,color: _mouseInside?Colors.white:logoMultiColor?null:color,size: 30,)
              else
                Icon(iconData,color: _mouseInside?Colors.white:logoMultiColor?null:color,size: 30,),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(text,style: TextStyle(
                  color: _mouseInside?Colors.white:color,
                  fontSize: 12
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
