import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:myresume/const.dart';


class MyUpdateExpandable extends StatelessWidget {

  final bool _lowWidth;

  MyUpdateExpandable(this._lowWidth);

  @override
  Widget build(BuildContext context) {
    Size _fullSize=MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: _lowWidth?0:_fullSize.width*0.2,
        ),
        Expanded(
          child: ExpandableNotifier(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Card(
                  color: kFinalScaffoldColor,
                  child: Column(
                    children: [
                      ScrollOnExpand(
                        scrollOnExpand: true,
                        scrollOnCollapse: true,
                        child: ExpandablePanel(
                          theme: ExpandableThemeData(
                            iconColor: Colors.white,
                            headerAlignment: ExpandablePanelHeaderAlignment.center,
                            tapHeaderToExpand: true,
                          ),
                          header: Padding(
                            padding: EdgeInsets.all(10),
                            child: AutoSizeText("Latest About Me",style: TextStyle(color: Colors.white,fontSize:25,fontWeight: FontWeight.bold),),
                          ),
                          expanded: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText("wbug wuigfb iwgfuwa ewuygf biwegf bewig faiwbfg iieg bcegbfgesjgtyuwatbrvg uywredrbtciuwaetb73g bvuiawge vuwegbytewagvisgvgw3rgfrwaevvwegrfyiesgvieisvgesugesuygerfg vg wewfgcwaehesyryrgiuweubwilcwhbcusdfbuyewrhawebfu3e3",maxLines: 40,minFontSize: 1,style: TextStyle(color: Colors.white),),
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
          width: _lowWidth?0:_fullSize.width*0.2,
        )
      ],
    );
  }
}

