import 'package:flutter/material.dart';
import 'package:myresume/const.dart';
import 'package:myresume/services/blog_services.dart';
import 'package:myresume/services/url_launcher.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class BlogPage extends StatelessWidget {

  final String postName;
  final String heading;

  const BlogPage({Key? key, required this.postName,required this.heading}) : super(key: key);

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

          return HtmlWidget(
            snapshot.data!,
            onTapUrl: (url){
              launchURL(url);
              return true;
            },
          );
        }
      )
    );
  }
}
