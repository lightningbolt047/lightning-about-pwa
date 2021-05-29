import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';


class MyUpdateExpandable extends StatefulWidget {

  final bool _lowWidth;
  final String heading,body;
  MyUpdateExpandable(this._lowWidth,this.heading,this.body);

  @override
  _MyUpdateExpandableState createState() => _MyUpdateExpandableState(this._lowWidth,this.heading,this.body);
}

class _MyUpdateExpandableState extends State<MyUpdateExpandable> with SingleTickerProviderStateMixin{
  final bool _lowWidth;
  late AnimationController _animationController;
  late Animation<double> _cardScaleAnimation;

  final String heading,body;

  _MyUpdateExpandableState(this._lowWidth,this.heading,this.body);




  @override
  void initState() {
    _animationController=AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500)
    );

    _cardScaleAnimation=Tween<double>(
      begin: 0.75,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn
    ));

    _animationController.forward();


    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _fullSize=MediaQuery.of(context).size;
    return ScaleTransition(
      scale: _cardScaleAnimation,
      child: Row(
        children: [
          SizedBox(
            width: _lowWidth?0:_fullSize.width*0.15,
          ),
          Expanded(
            child: ExpandableNotifier(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Card(
                    color: Colors.grey[800],
                    elevation: 5,
                    child: Column(
                      children: [
                        ScrollOnExpand(
                          scrollOnExpand: true,
                          scrollOnCollapse: true,
                          child: ExpandablePanel(
                            collapsed: Text(body,overflow:TextOverflow.ellipsis,maxLines: 1,style: TextStyle(color: Colors.white,fontSize: 17),),
                            theme: ExpandableThemeData(
                              iconColor: Colors.white,
                              headerAlignment: ExpandablePanelHeaderAlignment.center,
                              tapHeaderToExpand: true,
                            ),
                            header: Padding(
                              padding: EdgeInsets.all(10),
                              child: AutoSizeText(heading,style: TextStyle(color: Colors.white,fontSize:25,fontWeight: FontWeight.bold),),
                            ),
                            expanded: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(body,maxLines: 40,minFontSize: 1,style: TextStyle(color: Colors.white,fontSize: 17),),
                              ],
                            ),
                            builder: (context,collapsed,expanded){
                              return Padding(
                                padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                                child: Expandable(
                                  collapsed: collapsed,
                                  expanded: expanded,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ),
          ),
          SizedBox(
            width: _lowWidth?0:_fullSize.width*0.15,
          )
        ],
      ),
    );
  }
}


