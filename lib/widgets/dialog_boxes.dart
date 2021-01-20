import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myresume/const.dart';
import 'package:clipboard/clipboard.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:url_launcher/url_launcher.dart';


class SocialMediaHandles extends StatefulWidget {
  @override
  _SocialMediaHandlesState createState() => _SocialMediaHandlesState();
}

class _SocialMediaHandlesState extends State<SocialMediaHandles> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _emailSlideTransition;
  Animation<Offset> _handleSlideTransition;
  Animation<double> _dividerAnimation;


  bool _lowWidth=false;

  bool _copied=false;

  void _isLowWidth(){
    if(MediaQuery.of(context).size.width<600){
      _lowWidth=true;
    }
    return;
  }
  List<Widget> handlesNormal=[];
  List<Widget> handlesLowWidth=[];


  void _launchURL(String url) async{
    if(await canLaunch(url)){
      launch(url);
    }
    else{
      print("Couldn\'t launch URL ");
      throw "Can\'t launch $url";
    }
  }

  @override
  void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this,duration: Duration(seconds: 1));
    _emailSlideTransition=Tween<Offset>(
      begin: Offset(0,-0.5),
      end: Offset(0,0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutQuad,
      )
    );
    _handleSlideTransition=Tween<Offset>(
      begin: Offset(0,0.5),
      end: Offset(0,0),
    ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOutQuad,
        )
    );
    _dividerAnimation=Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate
    ));
    _controller.forward().orCancel;

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    Size _fullSize=MediaQuery.of(context).size;
    _isLowWidth();
    if(_lowWidth){
      handlesLowWidth=[
        GestureDetector(
          onTap: (){
            _launchURL(instagramProfileURL);
          },
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/instagram_icon.png'),
            backgroundColor: Colors.transparent,
            radius: _fullSize.width*0.03,
          ),
        ),
        GestureDetector(
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/linkedin_icon.png'),
            backgroundColor: Colors.transparent,
            radius: _fullSize.width*0.03,
          ),
          onTap: (){
            _launchURL(linkedInProfileURL);
          },
        ),
        GestureDetector(
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/github_icon.png'),
            backgroundColor: Colors.transparent,
            radius: _fullSize.width*0.03,
          ),
          onTap: (){
            _launchURL(githubProfileURL);
          },
        ),
        GestureDetector(
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/twitter_icon.png'),
            backgroundColor: Colors.transparent,
            radius: _fullSize.width*0.03,
          ),
          onTap: (){
            _launchURL(twitterProfileURL);
          },
        ),
      ];
    }
    else{
      handlesNormal=[
        FlatButton(
          shape: CircleBorder(),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/instagram_icon.png'),
            backgroundColor: Colors.transparent,
            radius: _fullSize.width*0.03,
          ),
          onPressed: (){
            _launchURL(instagramProfileURL);
          },
        ),
        FlatButton(
          shape: CircleBorder(),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/linkedin_icon.png'),
            backgroundColor: Colors.transparent,
            radius: _fullSize.width*0.03,
          ),
          onPressed: (){
            _launchURL(linkedInProfileURL);
          },
        ),
        FlatButton(
          shape: CircleBorder(),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/github_icon.png'),
            backgroundColor: Colors.transparent,
            radius: _fullSize.width*0.03,
          ),
          onPressed: (){
            _launchURL(githubProfileURL);
          },
        ),
        FlatButton(
          shape: CircleBorder(),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/twitter_icon.png'),
            backgroundColor: Colors.transparent,
            radius: _fullSize.width*0.03,
          ),
          onPressed: (){
            _launchURL(twitterProfileURL);
          },
        ),
      ];
    }
    print(_lowWidth);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      elevation: 3,
      backgroundColor: kFinalScaffoldColor,
      child: Container(
        height: _fullSize.height*0.75,
        width: _lowWidth?_fullSize.width:_fullSize.width*0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SlideTransition(
              position: _emailSlideTransition,
              child: Container(
                width: _lowWidth?_fullSize.width*0.7:_fullSize.width*0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Colors.black
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.email_outlined,color: Colors.white,),
                      AutoSizeText(email,minFontSize:1,maxFontSize:15,style: TextStyle(color: Colors.white,fontSize: _lowWidth?12:15),),
                      AnimatedContainer(
                        curve: Curves.easeInOut,
                        child: IconButton(
                          icon: Icon(_copied?Icons.check:Icons.copy,color: Colors.white,),
                          onPressed: () async{
                            await FlutterClipboard.copy(email);
                            setState(() {
                              _copied=true;
                            });
                            Timer(Duration(seconds: 5), (){
                              setState(() {
                                _copied=false;
                              });
                            });
                          },
                        ),
                        duration: Duration(seconds: 1),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: _fullSize.height*0.05,
            ),
            ScaleTransition(
              scale: _dividerAnimation,
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.white,
                      indent: 30,
                      endIndent: 10,
                    ),
                  ),
                  Text("Or find me on",style: TextStyle(color: Colors.white),),
                  Expanded(
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.white,
                      indent: 10,
                      endIndent: 30,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: _fullSize.height*0.05,
            ),
            SlideTransition(
              position: _handleSlideTransition,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _lowWidth?handlesLowWidth:handlesNormal,
              ),
            )
          ],
        ),
      ),
    );
  }
}
