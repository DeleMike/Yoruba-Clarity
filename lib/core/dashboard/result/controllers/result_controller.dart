import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:yoruba_clarity/boxes.dart';
import 'package:yoruba_clarity/core/dashboard/controllers/home_controller.dart';
import 'package:yoruba_clarity/core/local/flashcard.dart';
import 'package:yoruba_clarity/core/local/label.dart';

import '../../../../configs/debug_fns.dart';
import '../model/message.dart';

final resultProvider = ChangeNotifierProvider.autoDispose<ResultController>(
    (ref) => ResultController());

class ResultController with ChangeNotifier {
  List<String> _labels = [];
  List<String> get labels => _labels;

  List<Label> _existingLabels = [];
  List<Label> get existingLabels => _existingLabels;

  Future<List<Label>> getExistingLabels() async {
    // labelBox = await Hive.openBox<Flashcard>('labelBox');
    _existingLabels =
        labelBox.values.toList().map((e) => Label(name: e.name)).toList();

    print('Exisiting flashs from Home = ${_existingLabels.length}');
    return _existingLabels;
  }

  void setTagValue(List<String> vals) {
    _labels = vals;
    notifyListeners();
  }

  Future<void> saveLabel(String name) async {
    labelBox = await Hive.openBox<Label>('labelBox');
    printOut('Exisiting labels = ${labelBox.length}');
    final label = Label(name: name);
    await labelBox.put('${labelBox.length}', label);
    printOut('New Exisiting labels = ${flashcardBox.length}');

    await getExistingLabels();
    notifyListeners();
  }

  Future<void> saveText(Message message, HomeController homeController) async {
    flashcardBox = await Hive.openBox<Flashcard>('flashcardBox');

    printOut('Exisiting flashs = ${flashcardBox.length}');

    final flashcard = Flashcard(content: message.content, labels: _labels);
    print('Flashcard to save is: $flashcard');
    await flashcardBox.put('${flashcardBox.length}', flashcard);

    printOut('New Exisiting flashs = ${flashcardBox.length}');
    await homeController.getExistingFlashcards();
    notifyListeners();
  }
}
