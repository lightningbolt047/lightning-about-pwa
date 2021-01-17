import 'package:community_material_icon/community_material_icon.dart';
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


  void _isLowWidth(){
    if(MediaQuery.of(context).size.width<600){
      _lowWidth=true;
    }
    return;
  }


  @override
  void initState() {
    _tabController=TabController(length: 3,vsync: this,initialIndex: 0);
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
        title: Text("Skills"),
        backgroundColor: kFinalScaffoldColor,
        centerTitle: true,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MySkills(_lowWidth,_fullSize),
          MyProjects(),
          ContactMe(),
        ],

      ),
    );
  }
}




class MySkills extends StatefulWidget {

  final Size _fullSize;
  final bool _lowWidth;

  MySkills(this._lowWidth,this._fullSize);

  @override
  _MySkillsState createState() => _MySkillsState(this._lowWidth,this._fullSize);
}

class _MySkillsState extends State<MySkills> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Size _fullSize;
  bool _lowWidth;

  _MySkillsState(this._lowWidth,this._fullSize);

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
    return Center(
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
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
                          child: Text("DB",style: TextStyle(color: Colors.white,fontSize: 30),),
                        ),
                      ),
                    ],
                  ),
                ),

                VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: Colors.white,
                  indent: 40,
                  endIndent: 40,
                ),
                Container(
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
                              Image.asset('icon_pics/flutter.png',fit: BoxFit.contain,color: Colors.white,scale: 2.2,),
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
                              Icon(CommunityMaterialIcons.firebase,color: Colors.white,size: _lowWidth?35:60,),
                              Text("Firebase",style: TextStyle(color: Colors.white,fontSize: _lowWidth?8:15),),
                            ],
                          ),
                          SizedBox(
                            width: _lowWidth?_fullSize.width*0.01:_fullSize.width*0.02,
                          ),
                          Column(
                            children: [
                              Image.asset('icon_pics/mongodb.png',fit: BoxFit.contain,color: Colors.white,scale: _lowWidth?4:2.2,),
                              Text("MongoDB",style: TextStyle(color: Colors.white,fontSize: _lowWidth?8:15),),
                            ],
                          ),
                          SizedBox(
                            width: _lowWidth?_fullSize.width*0.01:_fullSize.width*0.02,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('icon_pics/sql.png',fit: BoxFit.contain,color: Colors.white,scale: _lowWidth?4:2.2,),
                              Text("SQL",style: TextStyle(color: Colors.white,fontSize: _lowWidth?8:15),),
                            ],
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
          Text("Other Skills",style: TextStyle(color: Colors.white,fontSize: 25),),
          Padding(
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
          )
        ],
      ),
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
