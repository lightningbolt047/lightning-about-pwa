import 'dart:convert';
import 'package:flutter/services.dart';

class BlogServices{

  static Future<List<dynamic>> getBlogPostMetadata() async{
    return jsonDecode(await rootBundle.loadString('blog_posts.json'));
  }

  static Future<String> getHTMLString(String postName) async{
    return rootBundle.loadString('assets/blog_posts/$postName/index.html');
  }

}