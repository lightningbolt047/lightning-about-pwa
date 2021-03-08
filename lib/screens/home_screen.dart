import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myresume/const.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:myresume/widgets/dialog_boxes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'fortnite_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'about_me_screen.dart';
import 'package:myresume/content.dart';

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
    _sliverScrollerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _fullSize=MediaQuery.of(context).size;
    _isLowWidth();
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
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.infoCircle,color: Colors.white,),
                      onPressed:(){
                        showDialog(
                          context: context,
                          builder: (context)=>AlertDialog(
                            title: Text("Alert"),
                            content: Text("Built with Flutter!\nFlutter: 2.0.1\nDart: 2.12.0"),
                            contentPadding: EdgeInsets.all(16),
                            actionsPadding: EdgeInsets.all(8),
                            actions: [
                              TextButton(
                                child:Text("OK"),
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    ),
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
                                  backgroundImage: AssetImage("assets/me.jpg"),
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
                                  fontSize: _fullSize.width*0.05,
                                  fontFamily: "Josefin"
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
            hasScrollBody: true,
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
                          begin: _lowWidth?Alignment.bottomCenter:Alignment.centerRight,
                          end: _lowWidth?Alignment.topCenter:Alignment.centerLeft,
                        ),
                      ),
                      child: AboutMeSection(_lowWidth,_fullSize),
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
                    child: FortniteCardSection(_lowWidth,_fullSize),
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
                    child: Image.asset('assets/home_screen_contact_me_card_image.jpg',fit: BoxFit.cover,),
                    height: _fullSize.height*0.3,
                    width: _fullSize.width,
                  ),
                  Container(
                    height: _fullSize.height*0.3,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black,Colors.transparent],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                      ),
                    ),
                    child: ContactMeCardSection(_lowWidth,_fullSize),
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



class AboutMeSection extends StatefulWidget {
  final bool _lowWidth;
  final Size _fullSize;

  AboutMeSection(this._lowWidth,this._fullSize);

  @override
  _AboutMeSectionState createState() => _AboutMeSectionState(this._lowWidth,this._fullSize);
}

class _AboutMeSectionState extends State<AboutMeSection> with SingleTickerProviderStateMixin {
  final bool _lowWidth;
  final Size _fullSize;

  _AboutMeSectionState(this._lowWidth,this._fullSize);


  String aboutText=frontPageContent;
  String buttonText="More info";


  AnimationController _animationController;
  Animation<double> _aboutTextAnimation;

  TextStyle _landscapeAboutTextStyle=TextStyle(color: Colors.white,fontSize: 20,);

  TextStyle _portraitAboutTextStyle=TextStyle(color: Colors.white,fontSize: 16);



  Function _onButtonPressedAction=(BuildContext context){
    Navigator.push(context, CupertinoPageRoute(builder: (context)=>AboutMe()));
  };



  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }






  @override
  void initState() {
    _animationController=AnimationController(
      vsync: this,
      duration: Duration(seconds: 1)
    );

    _aboutTextAnimation=Tween<double>(
      begin: 0,
      end: 1
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastLinearToSlowEaseIn
    ));

    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    if(_lowWidth){
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: FadeTransition(
          opacity: _aboutTextAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/me.jpg"),
                maxRadius: MediaQuery.of(context).size.height*0.07,
                minRadius: 10,
              ),
              SizedBox(
                width: _fullSize.height*0.05,
              ),
              Flexible(
                child: LayoutBuilder(
                  builder: (context,constraints){
                    double widgetHeight=constraints.maxHeight;
                    if(widgetHeight>200){
                      _animationController.forward();
                    }
                    else{
                      _animationController.reverse();
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: AutoSizeText(
                              aboutText,
                              style: _portraitAboutTextStyle,
                              maxFontSize: 20,
                              minFontSize: 1,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 25,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RawMaterialButton(
                    fillColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    splashColor: Colors.blueGrey,
                    hoverElevation: 7,
                    onPressed:(){
                      _onButtonPressedAction(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(buttonText,style: TextStyle(color: Colors.blue),),
                          Padding(
                            padding: const EdgeInsets.only(left:4.0),
                            child: Icon(Icons.chevron_right,color: Colors.blue,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FadeTransition(
        opacity: _aboutTextAnimation,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/me.jpg"),
              maxRadius: MediaQuery.of(context).size.width*0.05,
              minRadius: 10,
            ),
            SizedBox(
              width: _fullSize.width*0.1,
            ),
            Flexible(
              child: LayoutBuilder(
                builder: (context,constraints){
                  double widgetHeight=constraints.maxHeight;
                  if(widgetHeight>300){
                    _animationController.forward();
                  }
                  else{
                    _animationController.reverse();
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: AutoSizeText(
                            aboutText,
                            style: _landscapeAboutTextStyle,
                            maxFontSize: 25,
                            minFontSize: 5,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 25,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              width: _fullSize.width*0.1,
            ),
            RawMaterialButton(
              fillColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              splashColor: Colors.blueGrey,
              hoverElevation: 7,
              onPressed:(){
                _onButtonPressedAction(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(buttonText,style: TextStyle(color: Colors.blue),),
                    Padding(
                      padding: const EdgeInsets.only(left:4.0),
                      child: Icon(Icons.chevron_right,color: Colors.blue,),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class FortniteCardSection extends StatefulWidget {

  final bool _lowWidth;
  final Size _fullSize;

  FortniteCardSection(this._lowWidth,this._fullSize);

  @override
  _FortniteCardSectionState createState() => _FortniteCardSectionState(this._lowWidth,this._fullSize);
}

class _FortniteCardSectionState extends State<FortniteCardSection> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final bool _lowWidth;
  final Size _fullSize;

  double _minFontSize,_maxFontSize;

  _FortniteCardSectionState(this._lowWidth,this._fullSize);

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    if(_lowWidth){
      _minFontSize=10;
      _maxFontSize=17;
    }
    else{
      _minFontSize=10;
      _maxFontSize=20;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width:_lowWidth?_fullSize.width*0.5:_fullSize.width*0.3,
                  child: AutoSizeText("Did I tell you that I spend some of my free hours playing games?",minFontSize:_minFontSize,maxFontSize:_maxFontSize,maxLines:4,style: TextStyle(color: Colors.white,fontSize: _maxFontSize),)),
              Hero(
                tag: "HometoFortnite",
                child: RawMaterialButton(
                  fillColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  splashColor: Colors.blueGrey,
                  hoverElevation: 7,
                  onPressed:(){
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>FortniteScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text("Check out my game stats",style: TextStyle(color: Colors.blue),),
                        Padding(
                          padding: const EdgeInsets.only(left:4.0),
                          child: Icon(Icons.chevron_right,color: Colors.blue,),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}





class ContactMeCardSection extends StatefulWidget {

  final bool _lowWidth;
  final Size _fullSize;

  ContactMeCardSection(this._lowWidth,this._fullSize);

  @override
  _ContactMeCardSectionState createState() => _ContactMeCardSectionState(this._lowWidth,this._fullSize);
}

class _ContactMeCardSectionState extends State<ContactMeCardSection> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final bool _lowWidth;
  final Size _fullSize;

  double _minFontSize,_maxFontSize;

  _ContactMeCardSectionState(this._lowWidth,this._fullSize);

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    if(_lowWidth){
      _minFontSize=10;
      _maxFontSize=17;
    }
    else{
      _minFontSize=10;
      _maxFontSize=20;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                  alignment: Alignment.centerRight,
                  width:_lowWidth?_fullSize.width*0.5:_fullSize.width*0.3,
                  child: AutoSizeText("Want to contact me?",minFontSize:_minFontSize,maxFontSize:_maxFontSize,maxLines:4,style: TextStyle(color: Colors.white,fontSize: _maxFontSize),)),
              RawMaterialButton(
                fillColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                splashColor: Colors.blueGrey,
                hoverElevation: 7,
                onPressed:(){
                  showDialog(
                    context: context,
                    builder: (context)=>SocialMediaHandles()
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right:4.0),
                        child: Icon(Icons.chevron_left,color: Colors.blue,),
                      ),
                      Text("Find Me",style: TextStyle(color: Colors.blue),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}







