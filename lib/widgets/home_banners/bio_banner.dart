import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import '../../const.dart';
import '../../services/ui_services.dart';

class BioBanner extends StatelessWidget {
  const BioBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: homeScreenAppBarGradientColors,
        ),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
      ),
      child: LayoutBuilder(
        builder: (context,constraints){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  TypewriterAnimatedText("Sashank Visweshwaran",textStyle: TextStyle(
                      fontSize: isMobileDevice(constraints)?30:40,
                      color: Colors.white70
                  )),
                  TypewriterAnimatedText("LightningBolt047",textStyle: TextStyle(
                      fontSize: 40,
                      color: Colors.white70
                  )),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
