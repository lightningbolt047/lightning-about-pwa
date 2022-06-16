import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myresume/content.dart';
import 'dialog_boxes.dart';

class GitProjectCard extends StatefulWidget {

  final Map projectInfo;

  GitProjectCard(this.projectInfo);

  @override
  _GitProjectCardState createState() => _GitProjectCardState(this.projectInfo);
}

class _GitProjectCardState extends State<GitProjectCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<Offset> _contentSlideTransition;

  bool _lowWidth=false;
  final Map projectInfo;

  _GitProjectCardState(this.projectInfo);

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
          return ProjectDialog(this.projectInfo);
        }
    );
  }


  @override
  void initState() {
    _controller=AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _contentSlideTransition=Tween<Offset>(
      begin: Offset(0,0.5),
      end: Offset(0,0)
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn
    ));

    super.initState();

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
        child: SlideTransition(
          position: _contentSlideTransition,
          child: Card(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(getLanguageLogo(projectInfo['language'])),
                    backgroundColor: Colors.transparent,
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
                        AutoSizeText(projectInfo['name']+" ",overflow: TextOverflow.visible,minFontSize:5,maxFontSize:_lowWidth?20:30,maxLines: 1,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 25),),
                        AutoSizeText(projectInfo['language']+" ",overflow:TextOverflow.ellipsis,minFontSize:5,maxFontSize:20,maxLines:1,style: TextStyle(color: Colors.blue,fontSize: 15),),
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
      ),
    );
  }
}






