import 'package:flutter/material.dart';
import '../../const.dart';

class CountIndicator extends StatelessWidget {
  final Color? textColor;
  final IconData leadingIconData;
  final String value;
  const CountIndicator({Key? key,this.textColor=Colors.black54,required this.leadingIconData,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(leadingIconData,color: accentColor,size: 14,),
        SizedBox(
          width: 8,
        ),
        Text(value,style: TextStyle(
          fontWeight: FontWeight.w600,
          color: textColor,
          fontSize: 12
        ),),
        SizedBox(
          width: 18,
        ),
      ],
    );
  }
}
