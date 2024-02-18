import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yoruba_clarity/configs/color_palette.dart';

/// Creates light and dark [ThemeData].
class AppTheme {
  /// Light theme
  late ThemeData lightTheme;

  /// Dark theme
  late ThemeData darkTheme;

  /// Constructs an [AppTheme].
  AppTheme(BuildContext context) {
    lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.quicksand().fontFamily,
      brightness: Brightness.light,
      primaryColor: ColorPalette.kPrimaryColor,
      scaffoldBackgroundColor: ColorPalette.kCanvasColor,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: ColorPalette.kCanvasColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorPalette.kCanvasColor,
        foregroundColor: ColorPalette.kPrimaryColor,
        toolbarTextStyle: TextStyle(
          color: ColorPalette.kPrimaryColor,
          fontWeight: FontWeight.normal,
        ),
      ),
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: ColorPalette.kPrimaryColor),
      colorScheme: const ColorScheme.light(primary: Color(0xFF17253D))
          .copyWith(secondary: ColorPalette.kPrimaryColor),
      buttonTheme: ButtonTheme.of(context).copyWith(
        buttonColor: ColorPalette.kPrimaryColor,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return ColorPalette.kPrimaryColor.withOpacity(.48);
          }
          return ColorPalette.kPrimaryColor;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color>((states) {
          return ColorPalette.kPrimaryColor.withOpacity(.48);
        }),
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
            bodySmall: TextStyle(
              color: ColorPalette.kPrimaryColor,
              fontWeight: FontWeight.w400,
              fontSize: 12,
              fontFamily: GoogleFonts.quicksand().fontFamily,
            ),
            bodyMedium: TextStyle(
              color: ColorPalette.kPrimaryColor,
              fontWeight: FontWeight.w500,
              fontFamily: GoogleFonts.quicksand().fontFamily,
              fontSize: 14,
            ),
            bodyLarge: TextStyle(
              color: ColorPalette.kPrimaryColor,
              fontWeight: FontWeight.w500,
              fontFamily: GoogleFonts.quicksand().fontFamily,
              fontSize: 16,
            ),
            displayLarge: TextStyle(
              fontSize: 57,
              fontFamily: GoogleFonts.quicksand().fontFamily,
              fontWeight: FontWeight.normal,
              color: ColorPalette.kWhite,
            ),
            titleLarge: TextStyle(
              fontSize: 22,
              fontFamily: GoogleFonts.quicksand().fontFamily,
              fontWeight: FontWeight.bold,
            ),
            headlineLarge: TextStyle(
              fontSize: 32,
              fontFamily: GoogleFonts.quicksand().fontFamily,
              fontWeight: FontWeight.w400,
            ),
            headlineMedium: TextStyle(
              fontSize: 28,
              fontFamily: GoogleFonts.quicksand().fontFamily,
              fontWeight: FontWeight.w400,
            ),
            headlineSmall: TextStyle(
              fontSize: 24,
              fontFamily: GoogleFonts.quicksand().fontFamily,
              fontWeight: FontWeight.w400,
            ),
          ),
    );

    darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.quicksand().fontFamily,
      brightness: Brightness.dark,
      primaryColor: ColorPalette.kPrimaryColor,
      scaffoldBackgroundColor: ColorPalette.kBlack,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: ColorPalette.kCanvasColor,
      ),
      appBarTheme: const AppBarTheme(backgroundColor: ColorPalette.kBlack),
      colorScheme: const ColorScheme.dark(primary: Color(0xFF17253D))
          .copyWith(secondary: ColorPalette.kPrimaryColor),
      // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo).copyWith(secondary: kPrimaryColor),
      buttonTheme: ButtonTheme.of(context).copyWith(
        textTheme: ButtonTextTheme.primary,
        colorScheme: const ColorScheme.dark(primary: ColorPalette.kBlack)
            .copyWith(onPrimary: ColorPalette.kWhite),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      iconTheme: const IconThemeData(color: ColorPalette.kWhite),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return ColorPalette.kPrimaryColor.withOpacity(.48);
          }
          return ColorPalette.kPrimaryColor;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color>((states) {
          return ColorPalette.kPrimaryColor.withOpacity(.48);
        }),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: ColorPalette.kWhite),
      textTheme: ThemeData.light().textTheme.copyWith(
            bodySmall: TextStyle(
              color: ColorPalette.kWhite,
              fontWeight: FontWeight.w400,
              fontSize: 12,
              fontFamily: GoogleFonts.quicksand().fontFamily,
            ),
            bodyMedium: TextStyle(
              color: ColorPalette.kWhite,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              fontFamily: GoogleFonts.quicksand().fontFamily,
            ),
            bodyLarge: TextStyle(
              color: ColorPalette.kWhite,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              fontFamily: GoogleFonts.quicksand().fontFamily,
            ),
            displayLarge: TextStyle(
              fontSize: 57,
              fontWeight: FontWeight.normal,
              fontFamily: GoogleFonts.quicksand().fontFamily,
              color: ColorPalette.kWhite,
            ),
            titleLarge: TextStyle(
              fontSize: 22,
              fontFamily: GoogleFonts.quicksand().fontFamily,
              fontWeight: FontWeight.bold,
            ),
            headlineLarge: TextStyle(
              fontSize: 32,
              fontFamily: GoogleFonts.quicksand().fontFamily,
              fontWeight: FontWeight.w400,
            ),
            headlineMedium: TextStyle(
              fontSize: 28,
              fontFamily: GoogleFonts.quicksand().fontFamily,
              fontWeight: FontWeight.w400,
            ),
            headlineSmall: TextStyle(
              fontSize: 24,
              fontFamily: GoogleFonts.quicksand().fontFamily,
              fontWeight: FontWeight.w400,
            ),
          ),
    );
  }

  /// returns app current theme depending on if [isDarkMode] is ```true``` or otherwise
  ThemeData? themeData({required bool isDarkModeOn}) {
    return isDarkModeOn ? darkTheme : lightTheme;
  }
}
