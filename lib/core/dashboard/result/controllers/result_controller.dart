import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:yoruba_clarity/boxes.dart';
import 'package:yoruba_clarity/core/dashboard/controllers/home_controller.dart';
import 'package:yoruba_clarity/core/local/flashcard.dart';

import '../../../../configs/debug_fns.dart';
import '../model/message.dart';

final resultProvider = ChangeNotifierProvider.autoDispose<ResultController>(
    (ref) => ResultController());

class ResultController with ChangeNotifier {
  List<String> _labels = [];
  List<String> get labels => _labels;

  void setTagValue(List<String> vals) {
    _labels = vals;
    notifyListeners();
  }

  Future<void> saveText(Message message, HomeController homeController) async {
    flashcardBox = await Hive.openBox<Flashcard>('flashcardBox');

    printOut('Exisiting flashs = ${flashcardBox.length}');

    final flashcard = Flashcard(content: message.content, labels: _labels);
    await flashcardBox.put('${flashcardBox.length}', flashcard);

    printOut('New Exisiting flashs = ${flashcardBox.length}');
    await homeController.getExistingFlashcards();
    notifyListeners();
  }
}
