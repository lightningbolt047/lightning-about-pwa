import 'dart:async';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myresume/const.dart';
import 'package:myresume/services/http_services.dart';
import 'package:myresume/widgets/cards.dart';
import 'package:myresume/widgets/my_updates_expandable.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:myresume/content.dart';

class AboutMe extends StatefulWidget {
  @override
  _AboutMeState createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> with SingleTickerProviderStateMixin {

  TabController _tabController;
  double bottomNavBarOptionTextSize=20;

  List<String> _tabBarNames=['Skills','Projects','Updates'];

  bool _lowWidth=false;



  void _isLowWidth(){
    if(MediaQuery.of(context).size.width<600){
      _lowWidth=true;
    }
    return;
  }





  @override
  void initState() {
    _tabController=TabController(length: 3,vsync: this,initialIndex: 0);
    _tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    _isLowWidth();
    return Scaffold(
      backgroundColor: kFinalScaffoldColor,
      appBar: AppBar(
        title: Text("About Me",overflow:TextOverflow.visible,style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: kFinalScaffoldColor,
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          enableFeedback: true,
          tabs:[
            Tab(text: _tabBarNames[0],),
            Tab(text: _tabBarNames[1]),
            Tab(text: _tabBarNames[2]),
          ]
        ),
      ),
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: [
              MySkills(),
              MyProjects(),
              MoreAboutMe(),
            ],
          ),
          Visibility(
            visible: !_lowWidth,
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RawMaterialButton(
                    shape: CircleBorder(),
                    fillColor: Colors.white,
                    child: Icon(Icons.chevron_left,color: Colors.blue,),
                    onPressed: (){
                      if(_tabController.index!=0){
                        _tabController.animateTo(_tabController.index-1);
                      }
                    },
                  ),
                  RawMaterialButton(
                    shape: CircleBorder(),
                    fillColor: Colors.white,
                    child: Icon(Icons.chevron_right,color: Colors.blue,),
                    onPressed: (){
                      if(_tabController.index!=_tabBarNames.length-1){
                        _tabController.animateTo(_tabController.index+1);
                      }
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}




class MySkills extends StatefulWidget {

  @override
  _MySkillsState createState() => _MySkillsState();
}

class _MySkillsState extends State<MySkills> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  bool _lowWidth=false;

  Animation<Offset> _stackNameSlideAnimation;
  Animation<Offset> _frameworkSlideAnimation;
  Animation<Offset> _otherSkillsAnimation;
  Animation<double> _dividerScaleAnimation;



  void _isLowWidth(){
    if(MediaQuery.of(context).size.width<600){
      _lowWidth=true;
    }
    return;
  }



  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1,milliseconds: 150))..addListener(() {
      setState(() {});
    });

    _stackNameSlideAnimation=Tween<Offset>(
      begin: Offset(0.25,0),
      end: Offset(0,0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut
    ));

    _frameworkSlideAnimation=Tween<Offset>(
      begin: Offset(-0.25,0),
      end: Offset(0,0),
    ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut
    ));

    _otherSkillsAnimation=Tween<Offset>(
      begin: Offset(0,-0.25),
      end: Offset(0,0)
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut
    ));

    _dividerScaleAnimation=Tween<double>(
      begin: 0,
      end: 1
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear
    ));

    _controller.forward();

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


    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SlideTransition(
                        position: _stackNameSlideAnimation,
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          width: _fullSize.width*0.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                color: kFinalScaffoldColor,
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: AutoSizeText("FrontEnd ",minFontSize:15,style: TextStyle(color: Colors.white,fontSize: _lowWidth?25:30),),
                                ),
                              ),
                              SizedBox(
                                height: _fullSize.height*0.1,
                              ),
                              Container(
                                color: kFinalScaffoldColor,
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: AutoSizeText("BackEnd ",minFontSize:15,style: TextStyle(color: Colors.white,fontSize: _lowWidth?25:30),),
                                ),
                              ),
                              SizedBox(
                                height: _fullSize.height*0.1,
                              ),
                              Container(
                                color: kFinalScaffoldColor,
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: AutoSizeText("Database ",minFontSize:15,style: TextStyle(color: Colors.white,fontSize: _lowWidth?25:30),),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      ScaleTransition(
                        scale: _dividerScaleAnimation,
                        child: VerticalDivider(
                          width: 1,
                          thickness: 1,
                          color: Colors.white,
                          indent: 40,
                          endIndent: 40,
                        ),
                      ),
                      SlideTransition(
                        position: _frameworkSlideAnimation,
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          width: _fullSize.width*0.45,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(FontAwesomeIcons.react,color: Colors.white,size: (_lowWidth || _fullSize.height<600)?35:60,),
                                      Text("ReactJS",style: TextStyle(color: Colors.white, fontSize: _lowWidth?8:15),),
                                    ],
                                  ),
                                  SizedBox(
                                    width: _fullSize.width*0.02,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/flutter_icon.png',fit: BoxFit.contain,color: Colors.white,scale: (_lowWidth || _fullSize.height<600)?4:2.2,),
                                      Text("Flutter",style: TextStyle(color: Colors.white,fontSize: _lowWidth?8:15),)
                                    ],
                                  ),
                                  SizedBox(
                                    width: _fullSize.width*0.02,
                                  ),
                                  Column(
                                    children: [
                                      Icon(FontAwesomeIcons.html5,color: Colors.white,size: (_lowWidth || _fullSize.height<600)?35:60,),
                                      Text("HTML",style: TextStyle(color: Colors.white,fontSize: _lowWidth?8:15),)
                                    ],
                                  ),

                                ],
                              ),
                              SizedBox(
                                height: _fullSize.height*0.08,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(CommunityMaterialIcons.nodejs,color: Colors.white,size: 60,),
                                      Text("NodeJS",style: TextStyle(color: Colors.white),)
                                    ],
                                  ),
                                  SizedBox(
                                    width: _fullSize.width*0.02,
                                  ),
                                  Column(
                                    children: [
                                      Icon(CommunityMaterialIcons.language_php,color: Colors.white,size: 60,),
                                      Text("PHP",style: TextStyle(color: Colors.white),)
                                    ],
                                  ),

                                ],
                              ),
                              SizedBox(
                                height: _fullSize.height*0.08,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Icon(CommunityMaterialIcons.firebase,color: Colors.white,size: (_lowWidth || _fullSize.height<600)?35:60,),
                                      Text("Firebase",style: TextStyle(color: Colors.white,fontSize: _lowWidth?8:15),),
                                    ],
                                  ),
                                  SizedBox(
                                    width: _lowWidth?_fullSize.width*0.01:_fullSize.width*0.02,
                                  ),
                                  Column(
                                    children: [
                                      Image.asset('assets/mongodb_icon.png',fit: BoxFit.contain,color: Colors.white,scale: (_lowWidth || _fullSize.height<600)?4:2.2,),
                                      Text("MongoDB",style: TextStyle(color: Colors.white,fontSize: _lowWidth?8:15),),
                                    ],
                                  ),
                                  SizedBox(
                                    width: _lowWidth?_fullSize.width*0.01:_fullSize.width*0.02,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/sql_icon.png',fit: BoxFit.contain,color: Colors.white,scale: (_lowWidth || _fullSize.height<600)?4:2.2,),
                                      Text("SQL",style: TextStyle(color: Colors.white,fontSize: _lowWidth?8:15),),
                                    ],
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SlideTransition(position: _otherSkillsAnimation,child: Text("Other Skills",style: TextStyle(color: Colors.white,fontSize: 25),)),
                SlideTransition(
                  position: _otherSkillsAnimation,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.python,color: Colors.white,size: 60,),
                        SizedBox(
                          width: _fullSize.width*0.05,
                        ),
                        Icon(FontAwesomeIcons.java,color: Colors.white,size: 60,),
                        SizedBox(
                          width: _fullSize.width*0.05,
                        ),
                        Icon(CommunityMaterialIcons.language_cpp,color: Colors.white,size: 60,),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}






class MyProjects extends StatefulWidget {
  @override
  _MyProjectsState createState() => _MyProjectsState();
}

class _MyProjectsState extends State<MyProjects> {

  bool _lowWidth=false;

  GitServices _gitServices=GitServices();

  Future<List<dynamic>> _projectList;

  void populateData() async{
    _projectList=_gitServices.getGithubProjects();
    return;
  }



  void _isLowWidth(){
    if(MediaQuery.of(context).size.width<600){
      _lowWidth=true;
    }
    return;
  }

  @override
  void initState() {
    populateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _isLowWidth();
    Size _fullSize=MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: _lowWidth?_fullSize.width*0.9:_fullSize.width*0.7,
        child: FutureBuilder(
          future: _projectList,
          builder: (context,snapshot){
            if(snapshot.data==null){
              return LinearProgressIndicator();
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context,index){
                  return GitProjectCard(snapshot.data[index]);
              },
            );
          },
        ),
      ),
    );
  }
}




class MoreAboutMe extends StatefulWidget {
  @override
  _MoreAboutMeState createState() => _MoreAboutMeState();
}

class _MoreAboutMeState extends State<MoreAboutMe> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  bool _lowWidth=false;

  void _isLowWidth(){
    if(MediaQuery.of(context).size.width<600){
      _lowWidth=true;
    }
    return;
  }
  
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
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _isLowWidth();
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: _lowWidth?MainAxisAlignment.spaceAround:MainAxisAlignment.spaceEvenly,
              children: [
                AutoSizeText("My Resume",minFontSize:5,style: TextStyle(color: Colors.white, fontSize: _lowWidth?15:25,fontWeight: FontWeight.bold),),
                RawMaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  fillColor: Colors.white,
                  hoverElevation: 7,
                  onPressed: (){
                    _launchURL(websiteURL+'assets/assets/SashankVisweshwaran-CB.EN.U4CSE18354.pdf');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right:4.0),
                          child: Icon(Icons.cloud_download,color: Colors.blue,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:4.0),
                          child: Text("Download",style: TextStyle(color: Colors.blue),),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context,int index){
              return MyUpdateExpandable(_lowWidth,moreAboutMeHeading[index],moreAboutMeBody[index]);
            },
            childCount: min(moreAboutMeBody.length, moreAboutMeHeading.length)
          ),
        )
      ],
    );
  }
}
