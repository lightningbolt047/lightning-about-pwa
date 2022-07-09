import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myresume/screens/home_screen.dart';
void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  runApp(MaterialApp(
    home: DefaultTextStyle(
      style: GoogleFonts.quicksand(),
      child: HomeScreen(),
    ),
  ));
}




