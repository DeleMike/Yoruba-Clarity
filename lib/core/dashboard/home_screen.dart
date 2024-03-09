import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:yoruba_clarity/configs/color_palette.dart';
import 'package:yoruba_clarity/configs/constants.dart';
import 'package:yoruba_clarity/core/dashboard/controllers/home_controller.dart';
import 'package:yoruba_clarity/widgets/loading_screen.dart';
import 'package:yoruba_clarity/widgets/yc_app_bar.dart';

import '../../configs/app_router.dart';
import '../../configs/dimensions.dart';

// final texts = [
//   'Nàíjíríà',
//   'mo fẹ́ jẹun',
//   'Lẹ́yìn náà ni ó kọjú sí Labake padà Lẹ́yìn náà ni ó kọjú sí Labake padà Lẹ́yìn náà ni ó kọjú sí Labake padà...',
//   'Nàíjíríà',
//   'mo fẹ́ jẹun',
//   'Lẹ́yìn náà ni ó kọjú sí Labake padà Lẹ́yìn náà ni ó kọjú sí Labake padà Lẹ́yìn náà ni ó kọjú sí Labake padà...',
//   'Nàíjíríà',
//   'mo fẹ́ jẹun',
//   'Lẹ́yìn náà ni ó kọjú sí Labake padà Lẹ́yìn náà ni ó kọjú sí Labake padà Lẹ́yìn náà ni ó kọjú sí Labake padà...'
// ];

final texts = ['mo fẹ́ jẹun'];

final _addTextButton = GlobalKey();
final _playAudioButton = GlobalKey();

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void _createTutorial() {
    final targets = [
      TargetFocus(
        identify: '_addTextButton',
        keyTarget: _addTextButton,
        alignSkip: Alignment.topCenter,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Text(
                  'Use this button to start applying diacritics undiacritised Yorùbá words',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: ColorPalette.kWhite));
            },
          ),
        ],
      ),
      TargetFocus(
        identify: '_playAudioButton',
        keyTarget: _playAudioButton,
        alignSkip: Alignment.bottomCenter,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Text(
                  'Use this button to start listening to the pronunciation of your saved diacritised Yorùbá words',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: ColorPalette.kWhite));
            },
          ),
        ],
      ),
    ];

    final tutorialMark = TutorialCoachMark(targets: targets);
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        tutorialMark.show(context: context);
      },
    );
  }

  void checkForTutorialStatus() async {
    final homeController = ref.read(homeProvider);
    final hasBeenCoached = await homeController.hasUserBeenCoachedForHomeScreen();
    if (!hasBeenCoached) {
      _createTutorial();
      homeController.setUserHasBeenCoachedForHomeScreen();
    }
  }

  @override
  void initState() {
    super.initState();
    checkForTutorialStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YCAppBar(
          headerText: 'Your Saved Cards', needsABackButton: false),
      body: texts.isEmpty
          ? const Center(
              child: Text('No cards saved yet'),
            )
          : Padding(
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
                // primary: false,
                // shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
              ),
            ),
      //  const Center(
      //   child: Text('No diacritized Yorùbá text yet'),
      // ),
      floatingActionButton: FloatingActionButton(
        key: _addTextButton,
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
        border: Border.all(width: 5, color: ColorPalette.kBorderGrey),
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
              softWrap: true,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
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
                key: _playAudioButton,
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
