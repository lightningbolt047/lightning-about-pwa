import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GooglePlayDownloadButton extends StatelessWidget {
  final String link;
  const GooglePlayDownloadButton({Key? key,required this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Image.asset("assets/google-play-badge.png",scale: 4,),
      onPressed: () async{
        try{
          await launchUrl(Uri.parse(link));
        }catch(e){
          Future.error(e);
        }
      },
    );
  }
}
