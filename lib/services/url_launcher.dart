import 'package:url_launcher/url_launcher.dart';

void launchURL(String url) async{
  Uri uri=Uri.parse(url);
  if(await canLaunchUrl(uri)){
    launchUrl(uri);
  }
  else{
    print("Couldn\'t launch URL ");
    throw "Can\'t launch $url";
  }
}