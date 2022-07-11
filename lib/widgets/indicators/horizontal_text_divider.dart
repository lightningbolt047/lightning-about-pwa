import 'package:flutter/material.dart';
import 'package:myresume/services/ui_services.dart';

class HorizontalTextDivider extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  HorizontalTextDivider({required this.text, this.textStyle=const TextStyle(color: Colors.grey)});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Expanded(
                child: Divider(
                  thickness: 1,
                  indent: isMobileDevice(constraints)?null:constraints.maxWidth*0.1,
                  color: textStyle.color,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(text,style: textStyle,),
              ),
              Expanded(
                child: Divider(
                  thickness: 1,
                  endIndent: isMobileDevice(constraints)?null:constraints.maxWidth*0.1,
                  color: textStyle.color,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}