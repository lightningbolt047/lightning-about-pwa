import 'package:flutter/material.dart';
import 'package:myresume/services/project_language_logo.dart';
import 'package:myresume/services/url_launcher.dart';

import '../../services/ui_services.dart';

class GithubRepoCard extends StatelessWidget {
  final Map projectInfo;
  const GithubRepoCard({Key? key,required this.projectInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isMobileDevice(constraints)?constraints.maxWidth:constraints.maxWidth*0.75
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      child: Icon(getIconFromLanguage(projectInfo['language']),color: Colors.blue,size: 35,),
                      backgroundColor: Colors.transparent,
                      radius: 40,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(projectInfo['name'],style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500
                          ),),
                          Text(projectInfo['description']??"")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onPressed: (){
              launchURL(projectInfo['html_url']);
            },
          ),
        );
      }
    );
  }
}
