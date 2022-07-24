import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myresume/screens/blog_page.dart';
import '../../const.dart';
import '../../services/date_services.dart';
import 'package:animations/animations.dart';

class BlogPostCard extends StatefulWidget {
  final String heading;
  final String greeting;
  final String createdOn;
  final String user;
  final String postName;
  const BlogPostCard({Key? key,required this.heading,required this.greeting,required this.createdOn,required this.user,required this.postName}) : super(key: key);

  @override
  State<BlogPostCard> createState() => _BlogPostCardState(heading,greeting,createdOn,user,postName);
}

class _BlogPostCardState extends State<BlogPostCard> {

  final String heading;
  final String greeting;
  final String createdOn;
  final String user;
  final String postName;

  _BlogPostCardState(this.heading,this.greeting,this.createdOn,this.user,this.postName);

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
          child: OpenContainer(
            closedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            closedElevation: 0,
            closedBuilder: (context,openContainer)=>Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(greeting,style: TextStyle(
                        fontSize: 11
                    ),),
                    AnimatedDefaultTextStyle(
                      duration: Duration(milliseconds: 150),
                      style: TextStyle(
                        fontSize: 25,
                        color: _mousePresent?accentColor:Colors.black,
                      ),
                      child: Text(heading,),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.clock,size: 20,color: Colors.black54),
                            SizedBox(
                              width: 8,
                            ),
                            Text(getNiceStringDateFromISO(createdOn),style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black54
                            ),)
                          ],
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.circleUser,size: 20,color: Colors.black54),
                            SizedBox(
                              width: 8,
                            ),
                            Text(user,style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black54
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
                        openContainer();
                      },
                    ),
                  ],
                ),
              ),
            ),
            openBuilder: (context,closeContainer)=>BlogPage(postName: postName,heading: heading,),
          ),
        );
      }
    );
  }
}