import 'package:flutter/material.dart';
import 'package:myresume/const.dart';
import 'package:myresume/widgets/github_releases_download_button.dart';
import '../../services/ui_services.dart';

class AndroidToolboxBanner extends StatelessWidget {
  const AndroidToolboxBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1b1d21),Color(0xFF181d2b)]
        )
      ),
      child: LayoutBuilder(
        builder: (context,constraints){
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: isMobileDevice(constraints)?CrossAxisAlignment.center:CrossAxisAlignment.start,
                  children: [
                    Text("Android Toolbox",style: TextStyle(
                        fontSize: 40,
                        color: Colors.white70
                    ),),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isMobileDevice(constraints)?constraints.maxWidth*0.75:constraints.maxWidth*0.35,
                      ),
                      child: Text("An opensource desktop tool to access hidden features on your Android device",maxLines: 3,textAlign: isMobileDevice(constraints)?TextAlign.center:TextAlign.left,overflow: TextOverflow.ellipsis,style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),),
                    ),
                    SizedBox(height: 8,),
                    GithubReleasesDownloadButton(releasesURL: androidToolboxReleasesURL,)

                  ],
                ),
              ),
              if(!isMobileDevice(constraints))
                AnimatedContainer(
                  duration: Duration(milliseconds: 150),
                  constraints: BoxConstraints(
                    maxWidth: constraints.maxWidth*0.5,
                  ),
                  child: Image.asset("assets/android_toolbox_banner.png",colorBlendMode: BlendMode.darken,),
                ),

            ],
          );
        },
      ),
    );
  }
}
