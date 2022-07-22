import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myresume/widgets/buttons/label_icon_button.dart';
import 'package:myresume/widgets/indicators/count_indicator.dart';

import '../../const.dart';
import '../../services/ui_services.dart';

class BlogPostCard extends StatefulWidget {
  const BlogPostCard({Key? key}) : super(key: key);

  @override
  State<BlogPostCard> createState() => _BlogPostCardState();
}

class _BlogPostCardState extends State<BlogPostCard> {

  bool _mousePresent=false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints) {
        return MouseRegion(
          onEnter: (pointerEvent){
            setState(() {
              _mousePresent=true;
            });
          },
          onExit: (pointerEvent){
            setState(() {
              _mousePresent=false;
            });
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hello",style: TextStyle(
                    fontSize: 11
                  ),),
                  AnimatedDefaultTextStyle(
                    duration: Duration(milliseconds: 150),
                    style: TextStyle(
                      fontSize: 25,
                      color: _mousePresent?accentColor:Colors.black,
                    ),
                    child: Text("Hello Long content",),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.clock,size: 20,),
                          SizedBox(
                            width: 8,
                          ),
                          Text("July 22,2022",style: TextStyle(
                            fontWeight: FontWeight.w200
                          ),)
                        ],
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.circleUser,size: 20,),
                          SizedBox(
                            width: 8,
                          ),
                          Text("Sashank",style: TextStyle(
                            fontWeight: FontWeight.w200
                          ),)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Text("READ MORE",style: TextStyle(
                      color: accentColor
                    ),),
                    onPressed: (){

                    },
                  ),

                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
