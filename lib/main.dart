import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yoruba_clarity/core/local/flashcard.dart';
import 'package:yoruba_clarity/core/yoruba_clarity_app.dart';

import 'boxes.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FlashcardAdapter());
  flashcardBox = await Hive.openBox<Flashcard>('flashcardBox');
  runApp(const ProviderScope(child: YorubaClarityApp()));
}
