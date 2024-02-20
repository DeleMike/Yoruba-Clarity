import 'package:flutter/material.dart';
import 'package:yoruba_clarity/configs/color_palette.dart';
import 'package:yoruba_clarity/widgets/yc_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YCAppBar(headerText: 'Yorùbá Clarity', needsABackButton: false),
      body: const Center(
        child: Text('No diacritized Yorùbá text yet'),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'add-text',
        onPressed: () {},
        tooltip: 'Diacritize a Yorùbá text',
        shape: const StadiumBorder(),
        backgroundColor: ColorPalette.kAccentColor,
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
