import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yoruba_clarity/configs/color_palette.dart';

import 'dimensions.dart';

/// Defines the app's name
const String kAppName = 'Yoruba Clarity';

/// Defines app current version
const String kAppVersion = '1.0.0';

/// Theme font
String? kFontFamily = GoogleFonts.inter().fontFamily;

/// navigator key
final navigatorKey = GlobalKey<NavigatorState>();

/// messenger key
final messengerKey = GlobalKey<ScaffoldMessengerState>();

/// scaffold key
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

/// Show toast with [message]
void showToast(String message,
    {wantsLongText = false,
    wantsCenterMsg = false,
    textShouldBeInProd = false}) {
  if (kDebugMode) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: wantsLongText ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
        gravity: wantsCenterMsg ? ToastGravity.CENTER : ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorPalette.kPrimaryColor,
        textColor: ColorPalette.kWhite,
        fontSize: 16.0);
  } else if (!kDebugMode && textShouldBeInProd) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: wantsLongText ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
        gravity: wantsCenterMsg ? ToastGravity.CENTER : ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorPalette.kPrimaryColor,
        textColor: ColorPalette.kWhite,
        fontSize: 16.0);
  }
}

class SnackBarService {
  /// show a snackbar
  static void showSnackBar(
      {required String content, Color? color, int timeInSec = 4}) {
    final snackbar = SnackBar(
      backgroundColor: color ?? ColorPalette.kPrimaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kSmallRadius)),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: timeInSec),
      showCloseIcon: true,
      content: Padding(
        padding: const EdgeInsets.all(kPaddingS),
        child: Text(
          content,
          style: const TextStyle(
              color: ColorPalette.kWhite,
              fontSize:
                  14), //Theme.of(context).textTheme.bodyMedium!.copyWith(color: kWhite),
        ),
      ),
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }
}
