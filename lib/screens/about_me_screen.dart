import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myresume/const.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutMe extends StatefulWidget {
  @override
  _AboutMeState createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> with SingleTickerProviderStateMixin {

  TabController _tabController;
  bool _lowWidth=false;
  double bottomNavBarOptionTextSize=20;


  void _isLowWidth(){
    if(MediaQuery.of(context).size.width<600){
      _lowWidth=true;
      bottomNavBarOptionTextSize=17;
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
    Size _fullSize=MediaQuery.of(context).size;
    _isLowWidth();
    return Scaffold(
      backgroundColor: kFinalScaffoldColor,
      appBar: AppBar(
        title: Text("Skills",style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: kFinalScaffoldColor,
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: kFinalScaffoldColor,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Text("Skills",style: TextStyle(color: Colors.white,fontWeight: (_tabController.index==0)?FontWeight.bold:FontWeight.normal,fontSize: bottomNavBarOptionTextSize),),
                onTap: () {
                  _tabController.animateTo(0);
                },
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Text("Projects",style: TextStyle(color: Colors.white,fontWeight:(_tabController.index==1)?FontWeight.bold:FontWeight.normal,fontSize: bottomNavBarOptionTextSize),),
                onTap: (){
                  print("Settings pressed");
                  _tabController.animateTo(1);
                },
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Text("Contact Me",style: TextStyle(color: Colors.white,fontWeight:(_tabController.index==2)?FontWeight.bold:FontWeight.normal,fontSize: bottomNavBarOptionTextSize),),
                onTap: (){
                  print("Settings pressed");
                  _tabController.animateTo(2);
                },
              )
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MySkills(),
          MyProjects(),
          ContactMe(),
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
                              Card(
                                elevation: 0,
                                color: kFinalScaffoldColor,
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text("FrontEnd",style: TextStyle(color: Colors.white,fontSize: 30),),
                                ),
                              ),
                              SizedBox(
                                height: _fullSize.height*0.1,
                              ),
                              Card(
                                elevation: 0,
                                color: kFinalScaffoldColor,
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text("BackEnd",style: TextStyle(color: Colors.white,fontSize: 30),),
                                ),
                              ),
                              SizedBox(
                                height: _fullSize.height*0.1,
                              ),
                              Card(
                                elevation: 0,
                                color: kFinalScaffoldColor,
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text("Database",style: TextStyle(color: Colors.white,fontSize: 30),),
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
                                      Image.asset('assets/flutter_icon.png',fit: BoxFit.contain,color: Colors.white,scale: 2.2,),
                                      Text("Flutter",style: TextStyle(color: Colors.white),)
                                    ],
                                  ),
                                  SizedBox(
                                    width: _fullSize.width*0.02,
                                  ),
                                  Column(
                                    children: [
                                      Icon(FontAwesomeIcons.html5,color: Colors.white,size: 60,),
                                      Text("HTML",style: TextStyle(color: Colors.white),)
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

class _MyProjectsState extends State<MyProjects> with SingleTickerProviderStateMixin {
  AnimationController _controller;

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
    return Container();
  }
}




class ContactMe extends StatefulWidget {
  @override
  _ContactMeState createState() => _ContactMeState();
}

class _ContactMeState extends State<ContactMe> with SingleTickerProviderStateMixin {
  AnimationController _controller;

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
    return Container();
  }
}
