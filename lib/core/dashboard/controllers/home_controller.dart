import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../configs/constants.dart';
import '../../../configs/debug_fns.dart';

const homeTutorialKey = 'home_tutor';
const resultTutorialKey = 'result_tutor';

final homeProvider = ChangeNotifierProvider.autoDispose<HomeController>((ref) {
  return HomeController();
});

class HomeController with ChangeNotifier {
  Future<void> setUserHasBeenCoachedForHomeScreen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(homeTutorialKey, true);

    printOut('User has been tutored!');
    showToast('User has been tutored!');
  }

  Future<bool> hasUserBeenCoachedForHomeScreen() async {
    bool userBeenCoached = false;
    final prefs = await SharedPreferences.getInstance();
    userBeenCoached = prefs.getBool(homeTutorialKey) ?? false;
    printOut('User has been tutored = $userBeenCoached');
    return userBeenCoached;
  }

  Future<void> setUserHasBeenCoachedForResultScreen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(resultTutorialKey, true);

    printOut('User has been tutored!');
    showToast('User has been tutored!');
  }

  Future<bool> hasUserBeenCoachedForResultScreen() async {
    bool userBeenCoached = false;
    final prefs = await SharedPreferences.getInstance();
    userBeenCoached = await prefs.setBool(resultTutorialKey, true);

    return userBeenCoached;
  }
}
