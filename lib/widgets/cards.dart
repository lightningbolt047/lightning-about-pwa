import 'package:auto_size_text/auto_size_text.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GitProjectCard extends StatefulWidget {
  @override
  _GitProjectCardState createState() => _GitProjectCardState();
}

class _GitProjectCardState extends State<GitProjectCard> {
  bool _lowWidth=false;

  void _isLowWidth(){
    if(MediaQuery.of(context).size.width<600){
      _lowWidth=true;
    }
    return;
  }



  void onCardTapAction(){
    showGeneralDialog(
        context: context,
        barrierColor: Colors.transparent.withOpacity(0.5),
        barrierDismissible: true,
        barrierLabel: "Barrier",
        pageBuilder:(BuildContext context,Animation animation,Animation animation1){
          return ProjectDialog();
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    _isLowWidth();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          onCardTapAction();
        },
        child: Card(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
                child: CircleAvatar(
                  backgroundImage: NetworkImage("https://miro.medium.com/max/3000/1*MI686k5sDQrISBM6L8pf5A.jpeg"),
                  radius: 40,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText("Project Name",overflow:TextOverflow.ellipsis,minFontSize:10,maxFontSize:_lowWidth?20:30,maxLines: 1,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 25),),
                      AutoSizeText("Dart",overflow:TextOverflow.ellipsis,minFontSize:5,maxFontSize:20,maxLines:1,style: TextStyle(color: Colors.blue,fontSize: 15),),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right:8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chevron_right,color: Colors.blue,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




class ProjectDialog extends StatefulWidget {
  @override
  _ProjectDialogState createState() => _ProjectDialogState();
}

class _ProjectDialogState extends State<ProjectDialog> with SingleTickerProviderStateMixin {
  AnimationController _controller;


  Size _fullSize;
  bool _lowWidth=false;


  void _isLowWidth(){
    if(MediaQuery.of(context).size.width<600){
      _lowWidth=true;
    }
    return;
  }


  Widget getDialogContent(){
    if(_lowWidth){
      return Column();
    }
    return Column();
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
    _fullSize=MediaQuery.of(context).size;
    _isLowWidth();
    return Center(
      child: Container(
        width: _lowWidth?_fullSize.width*0.75:_fullSize.width*0.5,
        height: _fullSize.height*0.75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: Colors.white,
        ),
        child: getDialogContent(),
      ),
    );
  }
}

