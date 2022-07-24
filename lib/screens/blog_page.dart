import 'package:flutter/material.dart';
import 'package:myresume/const.dart';
import 'package:myresume/services/blog_services.dart';
import 'package:myresume/services/url_launcher.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

import '../services/ui_services.dart';

class BlogPage extends StatefulWidget {
  final String postName;
  final String heading;
  const BlogPage({Key? key,required this.postName,required this.heading}) : super(key: key);

  @override
  State<BlogPage> createState() => _BlogPageState(postName,heading);
}

class _BlogPageState extends State<BlogPage> {
  final String postName;
  final String heading;

  _BlogPageState(this.postName,this.heading);

  final ScrollController _scrollController=ScrollController();

  bool _mousePresent=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          backgroundColor: accentColor,
        ),
        body: FutureBuilder(
            future: BlogServices.getHTMLString(postName),
            builder: (BuildContext context,AsyncSnapshot<String> snapshot) {
              if(!snapshot.hasData){
                return Center(child: const CircularProgressIndicator());
              }

              return WebSmoothScroll(
                controller: _scrollController,
                child: MouseRegion(
                  onEnter: (pointerEvent){
                    setState((){
                      _mousePresent=true;
                    });
                  },
                  onExit: (pointerEvent){
                    setState((){
                      _mousePresent=false;
                    });
                  },
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: _mousePresent?NeverScrollableScrollPhysics():null,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: HtmlWidget(
                        snapshot.data!,
                        onTapUrl: (url){
                          launchURL(url);
                          return true;
                        },
                      ),
                    ),
                  ),
                ),
              );
            }
        )
    );
  }
}

