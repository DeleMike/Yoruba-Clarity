import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yoruba_clarity/configs/color_palette.dart';
import 'package:yoruba_clarity/configs/constants.dart';
import 'package:yoruba_clarity/widgets/loading_screen.dart';
import 'package:yoruba_clarity/widgets/yc_app_bar.dart';

import '../../configs/app_router.dart';
import '../../configs/dimensions.dart';

final texts = [
  'Nàíjíríà',
  'mo fẹ́ jẹun',
  'Lẹ́yìn náà ni ó kọjú sí Labake padà Lẹ́yìn náà ni ó kọjú sí Labake padà Lẹ́yìn náà ni ó kọjú sí Labake padà...'
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const YCAppBar(headerText: 'Yorùbá Clarity', needsABackButton: false),
      body: Padding(
        padding: const EdgeInsets.only(
            left: kPaddingM, top: kPaddingM, right: kPaddingM),
        child: GridView.builder(
          itemCount: texts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (ctx, index) {
            // ignore: avoid_print
            return InkWell(
              onTap: (() => print('Position ${texts[index]} clicked')),
              child: _AText(name: texts[index]),
            );
          },
          primary: false,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        ),
      ),
      //  const Center(
      //   child: Text('No diacritized Yorùbá text yet'),
      // ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'add-text',
        onPressed: () {
          context.push(AppRouter.addDiacriticsScreen);
        },
        tooltip: 'Diacritize a Yorùbá text',
        shape: const StadiumBorder(),
        backgroundColor: ColorPalette.kAccentColor,
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}

class _AText extends StatelessWidget {
  const _AText({
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: ColorPalette.kWhite,
        border: Border.all(width: 0.6, color: ColorPalette.kBorderGrey),
        borderRadius: const BorderRadius.all(
          Radius.circular(kSmallRadius),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              name,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: ColorPalette.kBlack),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(40),
                ),
                border: Border.all(width: 0.6, color: ColorPalette.kBorderGrey),
              ),
              child: IconButton(
                onPressed: () {
                  showToast('Play Audio Message of converted text');
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => const Center(
                      child: LoadingScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.play_arrow_rounded),
              ),
            ),
          )
        ],
      ),
    );
  }
}
