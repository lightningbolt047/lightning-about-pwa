import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myresume/const.dart';
import 'package:clipboard/clipboard.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_icon_button/animated_icon_button.dart';

import '../content.dart';


class SocialMediaHandles extends StatefulWidget {
  @override
  _SocialMediaHandlesState createState() => _SocialMediaHandlesState();
}

class _SocialMediaHandlesState extends State<SocialMediaHandles> with TickerProviderStateMixin {
  AnimationController _controller,_emailCopyAnimationController;
  Animation<Offset> _emailSlideTransition;
  Animation<Offset> _handleSlideTransition;
  Animation<double> _dividerAnimation;


  bool _lowWidth=false;


  void _isLowWidth(){
    if(MediaQuery.of(context).size.width<600){
      _lowWidth=true;
    }else{
      _lowWidth=false;
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
    _emailCopyAnimationController = AnimationController(vsync: this,duration: Duration(milliseconds: 250));
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
    _emailCopyAnimationController.dispose();
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
        MaterialButton(
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
        MaterialButton(
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
        MaterialButton(
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
        MaterialButton(
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
                width: _lowWidth?_fullSize.width*0.725:_fullSize.width*0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Colors.black
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:4.0),
                        child: Icon(Icons.email_outlined,color: Colors.white,),
                      ),
                      AutoSizeText(email,minFontSize:1,maxFontSize:15,style: TextStyle(color: Colors.white,fontSize: _lowWidth?_fullSize.width*0.03:_fullSize.width*0.015,fontWeight: FontWeight.w600),),
                      AnimatedIconButton(
                        icons: [
                          AnimatedIconItem(icon:Icon(Icons.copy,color: Colors.white,)),
                          AnimatedIconItem(icon:Icon(Icons.check,color: Colors.white,)),
                        ],
                        animationController: _emailCopyAnimationController,
                        enableFeedback: true,
                        onPressed: () async{
                          await FlutterClipboard.copy(email);
                          _emailCopyAnimationController.forward();
                          Timer(Duration(seconds: 5), (){
                            if(mounted){
                              _emailCopyAnimationController.reverse();
                            }
                          });
                        },
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





class ProjectDialog extends StatefulWidget {

  final Map projectInfo;

  ProjectDialog(this.projectInfo);

  @override
  _ProjectDialogState createState() => _ProjectDialogState(this.projectInfo);
}

class _ProjectDialogState extends State<ProjectDialog> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _headingScaleTransition;
  Animation<double> _contentFadeTransition;

  bool _lowWidth=false;

  final Map projectInfo;

  _ProjectDialogState(this.projectInfo);



  void _isLowWidth(BoxConstraints constraints){
    if(constraints.maxWidth<600){
      _lowWidth=true;
    }else{
      _lowWidth=false;
    }
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
    _controller = AnimationController(vsync: this,duration: Duration(milliseconds: 500));

    _headingScaleTransition=Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn
    ));

    _contentFadeTransition=Tween<double>(
      begin: 0,
      end: 1
    ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutExpo
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
    return LayoutBuilder(
      builder: (context,constraints){
        _isLowWidth(constraints);
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          elevation: 3,
          backgroundColor: kFinalScaffoldColor,
          child: Container(
            height: constraints.maxHeight*0.75,
            width: _lowWidth?constraints.maxWidth:constraints.maxWidth*0.5,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: AutoSizeText("Info",minFontSize: 10,maxFontSize: 20,style: TextStyle(color: Colors.white,fontSize: 20),),
                  stretch: true,
                  automaticallyImplyLeading: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft:Radius.circular(25),topRight: Radius.circular(25))
                  ),
                  actions: [
                    GestureDetector(
                      onTap: (){
                        _launchURL(projectInfo['html_url']);
                      },
                      child: Container(
                        padding: EdgeInsets.only(right: 8,top: 2,bottom: 2,left: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left:4.0,right: 8),
                              child: Text("Find it on",),
                            ),
                            VerticalDivider(
                              color: Colors.white,
                              thickness: 1,
                              indent: 10,
                              endIndent: 10,
                              width: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:8.0,right:4),
                              child: Icon(FontAwesomeIcons.github),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(topLeft:Radius.circular(20),bottomLeft: Radius.circular(20),topRight: Radius.circular(25),),
                        ),
                      ),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: _lowWidth?constraints.maxHeight*0.1:0,
                  ),
                ),
                SliverToBoxAdapter(
                  child: ScaleTransition(
                    scale: _headingScaleTransition,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: _lowWidth?constraints.maxWidth*0.2:constraints.maxWidth*0.1,
                        width: _lowWidth?constraints.maxWidth*0.2:constraints.maxWidth*0.1,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          image: DecorationImage(
                              image: AssetImage(getLanguageLogo(projectInfo['language'])),
                              fit: BoxFit.scaleDown
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ScaleTransition(
                    scale: _headingScaleTransition,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AutoSizeText(projectInfo['name'],style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w800),),
                        AutoSizeText(projectInfo['language'],style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w600),),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: _lowWidth?constraints.maxHeight*0.07:constraints.maxHeight*0.05,
                  ),
                ),
                SliverFadeTransition(
                  opacity: _contentFadeTransition,
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: AutoSizeText(
                        (projectInfo['name']=="lightning-about-pwa")?projectInfo['description']+"\n\nCodebase for the Progressive Web App that you are currently using":(projectInfo['description']==null?" ":projectInfo['description']),
                        maxLines: 40,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500,),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
