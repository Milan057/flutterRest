import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeModel extends ChangeNotifier {

  static ThemeData lightTheme = ThemeData(primarySwatch: createMaterialColor(Color(0xFF444473)),
      primaryColor: createMaterialColor(Color(0xFF444473)),
      cardColor:createMaterialColor(Color(0xFF797171)),
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      textTheme: TextTheme(

        headlineLarge: GoogleFonts.roboto(fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,fontSize: 60,color: createMaterialColor(Color(0xFF444473))),
        headlineMedium:GoogleFonts.roboto(fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,fontSize: 26,color: Colors.black),
        headlineSmall:GoogleFonts.roboto(fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,fontSize: 20,color: createMaterialColor(Color(0xFF444473))),
        bodyLarge: GoogleFonts.roboto(fontStyle: FontStyle.normal,fontWeight: FontWeight.normal,fontSize: 20)));


  ThemeData currentTheme=ThemeModel.lightTheme;

  static MaterialColor createMaterialColor(Color color) {
    List<int> strengths = <int>[50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
    Map<int, Color> swatch = <int, Color>{};
    final int primary = color.value;
    for (int index = 0; index < strengths.length; index++) {
      final double weight = 1 - (index / strengths.length);
      swatch[strengths[index]] = Color.lerp(Colors.black, Color(primary), weight)!;
    }
    return MaterialColor(primary, swatch);
  }
}