import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final resultProvider = ChangeNotifierProvider.autoDispose<ResultController>(
    (ref) => ResultController());

class ResultController with ChangeNotifier {
  List<String> _labels = [];
  List<String> get labels => _labels;

  void setTagValue(List<String> vals) {
    _labels = vals;
    notifyListeners();
  }
}
