import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:myresume/const.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'fortnite_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  ScrollController _sliverScrollerController=ScrollController();

  double _appBarCurrentSize=200;
  bool _lowWidth=false;

  void _isLowWidth(){
    if(MediaQuery.of(context).size.shortestSide<600){
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
    Size _fullSize=MediaQuery.of(context).size;
    _isLowWidth();
    print(_fullSize.width.toString());
    return Scaffold(
      backgroundColor: kFinalScaffoldColor,
      body: CustomScrollView(
        controller: _sliverScrollerController,
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            expandedHeight: _fullSize.height*0.7,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(FontAwesomeIcons.instagram,color: Colors.white,),
                      onPressed: (){
                        _launchURL(instagramProfileURL);
                      },
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.linkedinIn,color: Colors.white,),
                      onPressed: (){
                        _launchURL(linkedInProfileURL);
                      },
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.github,color: Colors.white,),
                      onPressed: (){
                        _launchURL(githubProfileURL);
                      },
                    )
                  ],
                ),
              ),
            ],
            flexibleSpace: LayoutBuilder(
              builder: (context,constraints){
                _appBarCurrentSize=constraints.biggest.height;
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        child: Container(
                          padding:EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Hero(
                                tag:"SplashIcon",
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage("https://miro.medium.com/max/3000/1*MI686k5sDQrISBM6L8pf5A.jpeg"),
                                  maxRadius: MediaQuery.of(context).size.width*0.1,
                                  minRadius: 20,
                                ),
                              ),
                              SizedBox(
                                width: _fullSize.width*0.1,
                              ),
                              TypewriterAnimatedTextKit(
                                text:["Sashank Visweshwaran","LightningBolt047"],
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: _fullSize.width*0.05
                                ),
                                isRepeatingAnimation: true,
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/home_screen_sliver_appbar_image.jpg',),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken)
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            bottom: PreferredSize(
              preferredSize: Size(0,0),
              child: Transform.translate(
                offset: Offset(0,15),
                child: RawMaterialButton(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(16),
                  elevation: 10,
                  fillColor: Colors.white,
                  splashColor: Colors.grey,
                  onPressed: (){
                    //Navigator.push(context, CupertinoPageRoute(builder: (context)=>FortniteScreen()));
                    _sliverScrollerController.animateTo(_appBarCurrentSize,duration: Duration(seconds: 1),curve: Curves.easeInExpo);
                  },
                  child: Icon(Icons.keyboard_arrow_down),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: Card(
              color: Colors.black,
              child: Stack(
                children: [
                  Container(
                    child: Image.asset('assets/home_screen_about_me_card_image.jpg',fit: BoxFit.cover,),
                    width: _fullSize.width,
                    height: _fullSize.height,
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.black,Colors.transparent],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage("https://miro.medium.com/max/3000/1*MI686k5sDQrISBM6L8pf5A.jpeg"),
                            maxRadius: MediaQuery.of(context).size.width*0.05,
                            minRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Card(
              color: Colors.black,
              child: Stack(
                children: [
                  Container(
                    child: Image.asset('assets/fortnite_home_screen_card_image.jpg',fit: BoxFit.cover,),
                    height: _fullSize.height*0.3,
                    width: _fullSize.width,
                  ),
                  Container(
                    height: _fullSize.height*0.3,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black,Colors.transparent],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
