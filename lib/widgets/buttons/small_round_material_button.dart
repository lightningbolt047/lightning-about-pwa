import 'package:flutter/material.dart';

class SmallRoundMaterialButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  const SmallRoundMaterialButton({Key? key,required this.onPressed,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: CircleBorder(),
      color: Colors.white70,
      child: Padding(
        padding: EdgeInsets.all(4),
        child: child,
      ),
      onPressed: onPressed,
    );
  }
}
