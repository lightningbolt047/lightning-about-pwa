import 'package:flutter/material.dart';

import '../../services/ui_services.dart';

class BlogPostCard extends StatefulWidget {
  const BlogPostCard({Key? key}) : super(key: key);

  @override
  State<BlogPostCard> createState() => _BlogPostCardState();
}

class _BlogPostCardState extends State<BlogPostCard> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          child: Container(
            width: isMobileDevice(constraints)?constraints.maxWidth:constraints.maxWidth*0.75,
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("OHAI THERE, IT'S BEEN A WHILE",style: TextStyle(
                  fontSize: 11
                ),),
                Text("Changelog 26 - Tailored Twelve, Audacious Automotive, Neat Networking, Devoted Developers",style: TextStyle(
                  fontSize: 30
                ),)

              ],
            ),
          ),
        );
      }
    );
  }
}
