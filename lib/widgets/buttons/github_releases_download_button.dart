import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../services/url_launcher.dart';

class GithubReleasesDownloadButton extends StatelessWidget {

  final String releasesURL;

  const GithubReleasesDownloadButton({Key? key,required this.releasesURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25)
        ),
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Icon(FontAwesomeIcons.github,color: Colors.white70,),
              VerticalDivider(
                indent: 2,
                endIndent: 2,
                thickness: 5,
                width: 5,
                color: Colors.white70,
              ),
              Text("Get it on Github releases",style: TextStyle(
                color: Colors.white70
              ),)
            ],
          ),
        ),
        onPressed: () async{
          launchURL(releasesURL);
        },
      ),
    );
  }
}
