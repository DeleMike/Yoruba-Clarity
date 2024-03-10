import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoruba_clarity/boxes.dart';

import '../../../configs/constants.dart';
import '../../../configs/debug_fns.dart';
import '../../../widgets/loading_screen.dart';
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

  Future<void> deleteText(BuildContext context, Flashcard flashcard) async {
    flashcardBox = await Hive.openBox<Flashcard>('flashcardBox');

    printOut('Exisiting flashs = ${flashcardBox.length - 1}');
    await flashcardBox.delete('${flashcardBox.length - 1}');

    printOut('New Exisiting flashs = ${flashcardBox.length}');
    await getExistingFlashcards().then((value) => context.pop());
    notifyListeners();
  }

  Future<void> playAudio(BuildContext context, String diacritizedWord) async {
    try {
      final yorubaTTsUrl = dotenv.env['YORUBA_TTS'];

      print('words to say: $diacritizedWord');
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => const Center(
          child: LoadingScreen(),
        ),
      );
      final player = AudioPlayer(); // Create a player
      final duration = await player.setUrl('$yorubaTTsUrl/$diacritizedWord');
      if (context.mounted) {
        context.pop();
      }

      await player.setSpeed(1.12); // Twice as fast
      await player.play();
      print('Duration took ${duration.toString()}');
    } catch (e, s) {
      context.pop();
      print('Error: $e, $s');
    }
  }
}
