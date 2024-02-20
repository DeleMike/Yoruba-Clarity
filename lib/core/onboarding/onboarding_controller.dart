import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yoruba_clarity/configs/debug_fns.dart';

final onboardingProvider = StateNotifierProvider.autoDispose<OnboaringNotifier, int>(
    (ref) => OnboaringNotifier());

class OnboaringNotifier extends StateNotifier<int> {
  OnboaringNotifier() : super(0);

  void next() {
    printOut('Next hit: $state');
    ++state;
    if (state == 3) {
      state = 0;
    }
  }
}
