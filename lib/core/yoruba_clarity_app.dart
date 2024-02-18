import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yoruba_clarity/configs/constants.dart';

import '../configs/app_router.dart';
import '../configs/app_theme.dart';
import '../configs/color_palette.dart';

class YorubaClarityApp extends StatelessWidget {
  const YorubaClarityApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: ColorPalette.kPrimaryColor,
      ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp.router(
      title: kAppName,
      theme: AppTheme(context).themeData(isDarkModeOn: false),
      scaffoldMessengerKey: messengerKey,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
