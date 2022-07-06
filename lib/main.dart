import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myresume/screens/home_screen.dart';

void main(){

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    home: DefaultTextStyle(
      style: GoogleFonts.quicksand(),
      child: HomeScreen(),
    ),
  ));
}




