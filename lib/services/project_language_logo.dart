
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

IconData getIconFromLanguage(String language){
  switch(language){
    case "Dart": return Icons.flutter_dash_rounded;
    case "Go": return FontAwesomeIcons.golang;
    case "Rust": return FontAwesomeIcons.rust;
    case "JavaScript": return FontAwesomeIcons.js;
    case "C++": return FontAwesomeIcons.c;
    case "Java": return FontAwesomeIcons.java;
    case "HTML": return FontAwesomeIcons.html5;
    case "Python": return FontAwesomeIcons.python;
    default: return FontAwesomeIcons.code;
  }
}