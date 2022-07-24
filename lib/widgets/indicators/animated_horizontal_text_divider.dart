import 'package:flutter/material.dart';
import 'package:myresume/services/ui_services.dart';

class AnimatedHorizontalTextDivider extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  const AnimatedHorizontalTextDivider({Key? key,required this.text,this.textStyle=const TextStyle(color: Colors.grey)}) : super(key: key);

  @override
  State<AnimatedHorizontalTextDivider> createState() => _AnimatedHorizontalTextDividerState(text,textStyle);
}

class _AnimatedHorizontalTextDividerState extends State<AnimatedHorizontalTextDivider> with SingleTickerProviderStateMixin {
  final String text;
  final TextStyle textStyle;

  _AnimatedHorizontalTextDividerState(this.text, this.textStyle);


  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    _scaleAnimation=Tween<double>(
      begin: 0,
      end: 1
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.decelerate));

    _animationController.forward();

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context,constraints) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Divider(
                      thickness: 1,
                      indent: isMobileDevice(constraints: constraints)?null:constraints.maxWidth*0.1,
                      color: textStyle.color,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(text,style: textStyle,),
                ),
                Expanded(
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Divider(
                      thickness: 1,
                      endIndent: isMobileDevice(constraints: constraints)?null:constraints.maxWidth*0.1,
                      color: textStyle.color,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}
