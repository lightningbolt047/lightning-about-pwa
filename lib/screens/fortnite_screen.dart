import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myresume/const.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:sliver_fill_remaining_box_adapter/sliver_fill_remaining_box_adapter.dart';
import 'package:myresume/services/http_services.dart';
import 'package:assets_audio_player/assets_audio_player.dart';


class FortniteScreen extends StatefulWidget {
  @override
  _FortniteScreenState createState() => _FortniteScreenState();
}

class _FortniteScreenState extends State<FortniteScreen> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  GameStats _gameStats=GameStats();

  Future<Map> _gameStatsResult;

  final assetsAudioPlayer=AssetsAudioPlayer();



  void playAudio() async{
    try{
      await assetsAudioPlayer.open(
          Audio.network('assets/assets/Glitter_lobby_music.mp3'), volume: 0.25
      );
      await _gameStatsResult;
      assetsAudioPlayer.play();
    }catch(e){
      print('File does not exist');
    }
  }



  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _gameStatsResult=_gameStats.getAccountStats();
    playAudio();
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
    return WillPopScope(
      onWillPop: () async{
        assetsAudioPlayer.stop();
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/fortnite_image.png'),
              fit: BoxFit.cover
            ),
          ),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                bottom: PreferredSize(
                  child: Container(),
                  preferredSize: Size(0,20),
                ),
                pinned: false,
                expandedHeight: _fullSize.height*0.4,
                flexibleSpace: Stack(
                  children: [
                    FlexibleSpaceBar(
                      titlePadding: EdgeInsets.only(top:24),
                      centerTitle: true,
                      title: Container(
                        padding:EdgeInsets.only(bottom: 8,top: 16),
                        child: Hero(
                          tag:"HometoFortnite",
                          child: Container(
                            child: Image.asset('assets/fortnite_logo.png',fit: BoxFit.contain,),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: kGameScreenBackgroundColor,
                          borderRadius: BorderRadius.vertical(top:Radius.circular(50))
                        ),
                      ),
                      bottom: -1,
                      left:0,
                      right: 0,
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: _gameStatsResult,
                builder: (context,snapshot){
                  if(snapshot.data==null){
                    return SliverToBoxAdapter(
                      child: LinearProgressIndicator(),
                    );
                  }

                  double soloWins,duoWins,squadWins,totalWins;
                  double soloElims,duoElims,squadElims,totalElims;
                  double soloMatchesPlayed,duoMatchesPlayed,squadMatchesPlayed,totalMatchesPlayed;
                  double soloPlayHours,duoPlayHours,squadPlayHours,totalPlayHours;

                  soloWins=snapshot.data['solo']['placetop1'];
                  duoWins=snapshot.data['duo']['placetop1'];
                  squadWins=snapshot.data['squad']['placetop1'];
                  totalWins=soloWins+duoWins+squadWins;

                  soloElims=snapshot.data['solo']['kills'];
                  duoElims=snapshot.data['duo']['kills'];
                  squadElims=snapshot.data['squad']['kills'];
                  totalElims=soloElims+duoElims+squadElims;

                  soloMatchesPlayed=snapshot.data['solo']['matchesplayed'];
                  duoMatchesPlayed=snapshot.data['duo']['matchesplayed'];
                  squadMatchesPlayed=snapshot.data['squad']['matchesplayed'];
                  totalMatchesPlayed=soloMatchesPlayed+duoMatchesPlayed+squadMatchesPlayed;

                  soloPlayHours=snapshot.data['solo']['minutesplayed']/60;
                  duoPlayHours=snapshot.data['duo']['minutesplayed']/60;
                  squadPlayHours=snapshot.data['squad']['minutesplayed']/60;
                  totalPlayHours=soloPlayHours+duoPlayHours+squadPlayHours;



                  return SliverList(
                    delegate: SliverChildListDelegate(
                        [
                          GlobalStatCard("Solo",soloWins,totalWins,soloElims,totalElims,soloMatchesPlayed,totalMatchesPlayed,soloPlayHours,totalPlayHours),
                          GlobalStatCard("Duo",duoWins,totalWins,duoElims,totalElims,duoMatchesPlayed,totalMatchesPlayed,duoPlayHours,totalPlayHours),
                          GlobalStatCard("Squad",squadWins,totalWins,squadElims,totalElims,squadMatchesPlayed,totalMatchesPlayed,squadPlayHours,totalPlayHours),

                        ]
                    ),
                  );
                },
              ),
              SliverFillRemainingBoxAdapter(
                child: Container(
                  color: kGameScreenBackgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class GlobalStatCard extends StatefulWidget {
  final String gameMode;
  final double wins,totalWins;
  final double elims,totalElims;
  final double matchesPlayed,totalMatchesPlayed;
  final double playHours,totalPlayHours;

  GlobalStatCard(this.gameMode,this.wins,this.totalWins,this.elims,this.totalElims,this.matchesPlayed,this.totalMatchesPlayed,this.playHours,this.totalPlayHours);

  @override
  _GlobalStatCardState createState() => _GlobalStatCardState(this.gameMode,this.wins,this.totalWins,this.elims,this.totalElims,this.matchesPlayed,this.totalMatchesPlayed,this.playHours,this.totalPlayHours);
}

class _GlobalStatCardState extends State<GlobalStatCard> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _headingSlideAnimation,_contentSlideAnimation;
  Animation<double> _fadeAnimation;
  bool _lowWidth=false;

  String gameMode;
  double wins,totalWins;
  double elims,totalElims;
  double matchesPlayed,totalMatchesPlayed;
  double playHours,totalPlayHours;

  _GlobalStatCardState(this.gameMode,this.wins,this.totalWins,this.elims,this.totalElims,this.matchesPlayed,this.totalMatchesPlayed,this.playHours,this.totalPlayHours);


  double getOuterSizedBoxesWidth(){
    if(MediaQuery.of(context).size.width<600){
      _lowWidth=true;
      return 0;
    }
    else{
      return MediaQuery.of(context).size.width*0.1;
    }
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this,duration: Duration(milliseconds: 500,seconds: 1))..addListener(() {setState(() {});});
    _headingSlideAnimation=Tween<Offset>(
      begin: Offset(0.25,0),
      end: Offset(0,0)
    ).animate(CurvedAnimation(
      curve: Curves.decelerate,
      parent: _controller
    ));
    _contentSlideAnimation=Tween<Offset>(
        begin: Offset(-0.25,0),
        end: Offset(0,0)
    ).animate(CurvedAnimation(
        curve: Curves.easeInQuad,
        parent: _controller
    ));

    _fadeAnimation=Tween<double>(
      begin: 0,
      end: 1
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate
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
    return Material(
      color: kGameScreenBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: getOuterSizedBoxesWidth(),
          ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      title: Text("Source"),
                      content: Text("Data obtained from fortniteapi.io\nSeriously? You thought I would update this data manually?"),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            child: Text("OK"),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    );
                  }
                );
              },
              child: Card(
                color: kFinalScaffoldColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: _lowWidth?0:_fullSize.width*0.1,
                    ),
                    Container(
                      width: _lowWidth?_fullSize.width*0.2:_fullSize.width*0.25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: SlideTransition(
                              position: _headingSlideAnimation,
                              child: AutoSizeText(gameMode,minFontSize:5,overflow: TextOverflow.ellipsis,style: TextStyle(
                                  fontSize: _fullSize.width*0.05,
                                  color: Colors.white
                              ),),
                            ),
                          ),
                          Container(
                            height: _fullSize.height*0.1,
                            child: VerticalDivider(
                              color: Colors.white,
                              indent: _fullSize.height*0.01,
                              endIndent: _fullSize.height*0.01,
                              thickness: 2,
                              width: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _contentSlideAnimation,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: _lowWidth?_fullSize.width*0.2:_fullSize.width*0.1,
                                    child: Text("Wins",maxLines:1,style: TextStyle(color: Colors.white,fontSize: _lowWidth?_fullSize.width*0.025:_fullSize.width*0.01),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 8,right: 8),
                                    width:_lowWidth?_fullSize.width*0.25:_fullSize.width*0.1,
                                    child: FAProgressBar(
                                      currentValue: (wins*100)~/totalWins,
                                      maxValue: 100,
                                      size: 5,
                                      direction: Axis.horizontal,
                                      borderRadius: 30,
                                      backgroundColor: Colors.transparent,
                                      progressColor: Colors.blue,
                                      animatedDuration: Duration(seconds: 2),
                                    ),
                                  ),
                                  Text(wins.toString(),style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: _lowWidth?_fullSize.width*0.2:_fullSize.width*0.1,
                                    child: Text("Eliminations",maxLines:1,style: TextStyle(color: Colors.white,fontSize: _lowWidth?_fullSize.width*0.025:_fullSize.width*0.01),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 8,right: 8),
                                    width:_lowWidth?_fullSize.width*0.25:_fullSize.width*0.1,
                                    child: FAProgressBar(
                                      currentValue: (elims*100)~/totalElims,
                                      maxValue: 100,
                                      size: 5,
                                      direction: Axis.horizontal,
                                      borderRadius: 30,
                                      backgroundColor: Colors.transparent,
                                      progressColor: Colors.red,
                                      animatedDuration: Duration(seconds: 2),
                                    ),
                                  ),
                                  Text(elims.toString(),style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: _lowWidth?_fullSize.width*0.2:_fullSize.width*0.1,
                                    child: Text("Matches Played",maxLines:1,style: TextStyle(color: Colors.white,fontSize: _lowWidth?_fullSize.width*0.025:_fullSize.width*0.01),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 8,right: 8),
                                    width:_lowWidth?_fullSize.width*0.25:_fullSize.width*0.1,
                                    child: FAProgressBar(
                                      currentValue: (matchesPlayed*100)~/totalMatchesPlayed,
                                      maxValue: 100,
                                      size: 5,
                                      direction: Axis.horizontal,
                                      borderRadius: 30,
                                      backgroundColor: Colors.transparent,
                                      progressColor: Colors.orangeAccent,
                                      animatedDuration: Duration(seconds: 2),
                                    ),
                                  ),
                                  Text(matchesPlayed.toString(),style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: _lowWidth?_fullSize.width*0.2:_fullSize.width*0.1,
                                    child: Text("Play Hours",maxLines:1,style: TextStyle(color: Colors.white,fontSize: _lowWidth?_fullSize.width*0.025:_fullSize.width*0.01),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 8,right: 8),
                                    width:_lowWidth?_fullSize.width*0.25:_fullSize.width*0.1,
                                    child: FAProgressBar(
                                      currentValue: ((playHours*100)~/totalPlayHours),
                                      maxValue: 100,
                                      size: 5,
                                      direction: Axis.horizontal,
                                      borderRadius: 30,
                                      backgroundColor: Colors.transparent,
                                      progressColor: Colors.cyan  ,
                                      animatedDuration: Duration(seconds: 2),
                                    ),
                                  ),
                                  Text(playHours.toStringAsFixed(1),style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            ),


                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: _fullSize.width*0.01,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: getOuterSizedBoxesWidth(),
          ),
        ],
      ),
    );
  }
}



