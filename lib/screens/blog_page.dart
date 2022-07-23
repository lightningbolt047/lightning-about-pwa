import 'package:flutter/material.dart';
import 'package:myresume/const.dart';
import 'package:myresume/services/url_launcher.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        backgroundColor: accentColor,
      ),
      body: HtmlWidget(
        "<HTML><body>Hello world</body></HTML>",
        onTapUrl: (url){
          launchURL(url);
          return true;
        },
      )
    );
  }
}
