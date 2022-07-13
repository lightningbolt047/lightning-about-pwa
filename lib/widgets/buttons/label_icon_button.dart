import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class LabelIconButton extends StatelessWidget {
  final Color color;
  final String? label;
  final IconData? iconData;
  final String? iconifyString;
  final bool logoMultiColor;
  final VoidCallback onPressed;
  const LabelIconButton({Key? key,this.color=Colors.white,this.label,this.iconData,this.iconifyString,this.logoMultiColor=false,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: (label==null)?CircleBorder():RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            if(iconData!=null)...[
              Icon(iconData,color: color,size: 30,),
            ]else if(iconifyString!=null)
              Iconify(iconifyString!,color: color,size: 30,),
            if(label!=null)
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(label!,style: TextStyle(
                  color: color,
                  fontSize: 15
                ),),
              ),
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }
}
