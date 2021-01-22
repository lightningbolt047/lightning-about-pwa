import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'dart:async';
import 'home_screen.dart';
import '../const.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  AnimationController _animationController;
  AnimationController _colorAnimationController;

  Animation<Offset> _slideAnimation;
  Animation<Color> _scaffoldColorAnimation;
  bool _circleContainer=false;


  @override
  void dispose() {
    _animationController.dispose();
    _colorAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _colorAnimationController=AnimationController(
      duration: Duration(seconds: 2),
      vsync: this
    );

    _animationController=AnimationController(
      duration: Duration(seconds: 2),
      vsync: this
    );

    _slideAnimation=Tween<Offset>(
      begin: Offset(0,0),
      end: Offset(0,-20)
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn
    ));

    _scaffoldColorAnimation=ColorTween(
      begin: kInitialScaffoldColor,
      end: kFinalScaffoldColor
    ).animate(CurvedAnimation(
      parent: _colorAnimationController,
      curve: Curves.easeInQuad
    ))..addListener(() {setState(() {});});

    Timer(Duration(seconds: 5),(){
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=>HomeScreen()));
    });

    _animationController.reverse(from: 1).whenComplete((){
      setState(() {
        _circleContainer=true;
      });
      _colorAnimationController.forward();
    });

  }
  @override
  Widget build(BuildContext context) {
    Size _fullSize=MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: _scaffoldColorAnimation.value,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideTransition(
                  child: AnimatedContainer(
                      duration: Duration(seconds: 2),
                      height: _circleContainer?150:150,
                      width: _circleContainer?150:150,
                      child: Center(
                        child: Hero(
                          tag: "SplashIcon",
                          child: Icon(CommunityMaterialIcons.lightning_bolt,color: Colors.yellow,size: _circleContainer?100:150,),
                        ),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _circleContainer?Colors.blue:Colors.transparent,
                      ),

                  ),
                  position: _slideAnimation,
                ),
              ],
            ),
            SizedBox(
              height: _fullSize.height*0.1,
            ),
            ScaleTransition(
              scale: _animationController,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(child: LinearProgressIndicator(),
                    width: _fullSize.width*0.25,
                    height: 8,
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
