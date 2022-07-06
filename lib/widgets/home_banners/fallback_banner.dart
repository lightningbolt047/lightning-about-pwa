import 'package:flutter/material.dart';
import '../../const.dart';
import '../../services/ui_services.dart';
import 'package:url_launcher/url_launcher.dart';

class FallbackBanner extends StatelessWidget {
  const FallbackBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFE8E7D1),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
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
                    Text("Fallback",style: TextStyle(
                        fontSize: 40,
                        color: Color(0xFF686750)
                    ),),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isMobileDevice(constraints)?constraints.maxWidth*0.75:constraints.maxWidth*0.35,
                      ),
                      child: Text("Now store your backup keys securely with a beautiful UI",textAlign: isMobileDevice(constraints)?TextAlign.center:TextAlign.left,maxLines: 3,overflow: TextOverflow.ellipsis,style: TextStyle(
                        color: Color(0xFF686750),
                        fontSize: 16,
                      ),),
                    ),
                    SizedBox(height: 8,),
                    GestureDetector(
                      child: Image.asset("assets/google-play-badge.png",scale: 4,),
                      onTap: () async{
                        try{
                          await launchUrl(Uri.parse(fallbackGooglePlayStoreLink));
                        }catch(e){
                          Future.error(e);
                        }
                      },
                    )
                  ],
                ),
              ),
              if(!isMobileDevice(constraints))
                AnimatedContainer(
                  duration: Duration(milliseconds: 150),
                  constraints: BoxConstraints(
                    maxWidth: constraints.maxWidth*0.5,
                  ),
                  child: Image.asset("assets/fallback_banner.png",colorBlendMode: BlendMode.darken,),
                ),

            ],
          );
        },
      ),
    );
  }
}

