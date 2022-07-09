import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myresume/const.dart';
import 'package:myresume/services/date_services.dart';
import 'package:myresume/services/project_language_logo.dart';
import 'package:myresume/services/url_launcher.dart';

import '../../services/ui_services.dart';
import '../indicators/count_indicator.dart';

class GithubRepoCard extends StatefulWidget {
  final Map projectInfo;
  const GithubRepoCard({Key? key,required this.projectInfo}) : super(key: key);

  @override
  State<GithubRepoCard> createState() => _GithubRepoCardState(projectInfo);
}

class _GithubRepoCardState extends State<GithubRepoCard> {

  final Map projectInfo;

  _GithubRepoCardState(this.projectInfo);

  bool _mousePresent=false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
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
      child: LayoutBuilder(
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
                          child: Icon(getIconFromLanguage(projectInfo['language']),color: accentColor,size: 35,),
                          backgroundColor: Colors.transparent,
                          radius: 40,
                        ),
                        Expanded(
                          child: AnimatedDefaultTextStyle(
                            duration: Duration(milliseconds: 150),
                            style: TextStyle(
                              color: _mousePresent?accentColor:Colors.black,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(projectInfo['name'],style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600
                                ),),
                                Row(
                                  children: [
                                    CountIndicator(
                                      value: projectInfo['language'],
                                      leadingIconData: FontAwesomeIcons.code,
                                      textColor: _mousePresent?accentColor:Colors.black54,
                                    ),
                                    // CountIndicator(
                                    //   value: projectInfo['stargazers_count'].toString(),
                                    //   leadingIconData: FontAwesomeIcons.star,
                                    //   textColor: _mousePresent?Colors.blue:null,
                                    // ),
                                    // CountIndicator(
                                    //   value: projectInfo['watchers_count'].toString(),
                                    //   leadingIconData: FontAwesomeIcons.eye,
                                    //   textColor: _mousePresent?Colors.blue:null,
                                    // ),
                                    // CountIndicator(
                                    //   value: projectInfo['default_branch'].toString(),
                                    //   leadingIconData: FontAwesomeIcons.codeFork,
                                    //   textColor: _mousePresent?Colors.blue:null,
                                    // ),
                                    CountIndicator(
                                      leadingIconData: Icons.calendar_month_rounded,
                                      value: getDifferenceInTimeString(projectInfo['created_at']),
                                      textColor: _mousePresent?accentColor:Colors.black54,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(projectInfo['description']??"",style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black54
                                ),)
                              ],
                            ),
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
      ),
    );
  }
}
