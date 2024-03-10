import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoruba_clarity/boxes.dart';

import '../../../configs/constants.dart';
import '../../../configs/debug_fns.dart';
import '../../local/flashcard.dart';

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

  List<Flashcard> myFlashs = [];

  Future<void> getExistingFlashcards() async {
    flashcardBox = await Hive.openBox<Flashcard>('flashcardBox');
    myFlashs = flashcardBox.values
        .toList()
        .map((e) => Flashcard(content: e.content, labels: e.labels))
        .toList();
    print('Exisiting flashs from Home = ${myFlashs.length}');
    notifyListeners();
  }
}
