import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myresume/const.dart';
import 'package:myresume/widgets/indicators/language_icon_indicator.dart';
import 'package:colorful_iconify_flutter/icons/vscode_icons.dart';
import 'package:colorful_iconify_flutter/icons/logos.dart';

class AboutMeSection extends StatelessWidget {
  const AboutMeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints){
        return SingleChildScrollView(
          child: Column(
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  LanguageIconIndicator(iconifyString: VscodeIcons.file_type_flutter, text: "Flutter",color: flutterBlue,logoMultiColor: true,),
                  LanguageIconIndicator(iconData: FontAwesomeIcons.react, text: "React",color: reactBlue,),
                  LanguageIconIndicator(iconData: FontAwesomeIcons.html5, text: "HTML",color: htmlOrange,),
                  LanguageIconIndicator(iconData: FontAwesomeIcons.nodeJs, text: "NodeJS",color: nodeJSGreen,),
                  LanguageIconIndicator(iconifyString: VscodeIcons.file_type_mongo,text: "MongoDB",color: mongoDBGreen,logoMultiColor: true,),
                  LanguageIconIndicator(iconifyString: VscodeIcons.file_type_firebase,text: "Firebase",color: firebaseYellow,logoMultiColor: true,),
                  LanguageIconIndicator(iconifyString: VscodeIcons.file_type_sql,text: "SQL",color: sqlYellow,logoMultiColor: true,),
                  LanguageIconIndicator(iconifyString: Logos.java,text: "Java",color: javaOrange,logoMultiColor: true,),
                  LanguageIconIndicator(iconifyString: VscodeIcons.file_type_python,text: "Python",color: pythonBlue,logoMultiColor: true,),

                ],
              )
            ],
          ),
        );
      },
    );
  }
}
