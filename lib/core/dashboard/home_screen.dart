import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:yoruba_clarity/boxes.dart';
import 'package:yoruba_clarity/configs/color_palette.dart';
import 'package:yoruba_clarity/configs/constants.dart';
import 'package:yoruba_clarity/configs/debug_fns.dart';
import 'package:yoruba_clarity/core/dashboard/controllers/home_controller.dart';
import 'package:yoruba_clarity/core/dashboard/result/controllers/result_controller.dart';
import 'package:yoruba_clarity/core/local/flashcard.dart';
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
      // if (flashcardBox.isNotEmpty)
      //   TargetFocus(
      //     identify: '_playAudioButton',
      //     keyTarget: _playAudioButton,
      //     alignSkip: Alignment.bottomCenter,
      //     contents: [
      //       TargetContent(
      //         align: ContentAlign.bottom,
      //         builder: (context, controller) {
      //           return Text(
      //               'Use this button to start listening to the pronunciation of your saved diacritised Yorùbá words',
      //               style: Theme.of(context)
      //                   .textTheme
      //                   .bodyMedium!
      //                   .copyWith(color: ColorPalette.kWhite));
      //         },
      //       ),
      //     ],
      //   ),
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
    final hasBeenCoached =
        await homeController.hasUserBeenCoachedForHomeScreen();
    if (!hasBeenCoached) {
      _createTutorial();
      homeController.setUserHasBeenCoachedForHomeScreen();
    }

    await homeController.getExistingFlashcards();
  }

  @override
  void initState() {
    super.initState();
    checkForTutorialStatus();
  }

  @override
  Widget build(BuildContext context) {
    final List<GlobalObjectKey<FormState>> keyList = List.generate(
        flashcardBox.length, (index) => GlobalObjectKey<FormState>(index));
    final flashs = ref.watch(homeProvider).myFlashs;
    return Scaffold(
      appBar: YCAppBar(
          headerText: 'Your Saved Cards: ${flashs.length}',
          needsABackButton: false),
      body: flashcardBox.isEmpty
          ? const Center(
              child: Text('No cards saved yet'),
            )
          : Padding(
              padding: const EdgeInsets.only(
                  left: kPaddingM, top: kPaddingM, right: kPaddingM),
              child: GridView.builder(
                itemCount: flashs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (ctx, index) {
                  final lists = flashs.reversed.toList();
                  Flashcard flashcard = lists[index];

                  return InkWell(
                    onTap: () {
                      final args = {'flashcard': flashcard};
                      if (context.mounted) {
                        context.pushNamed(
                          AppRouter.viewScreen.substring(1),
                          extra: args,
                        );
                      }
                    },
                    child: _AText(
                        name: flashcard.content,
                        key_: index == 0 ? _playAudioButton : keyList[index]),
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

class _AText extends ConsumerWidget {
  const _AText({
    required this.name,
    required this.key_,
  });

  final String name;
  final GlobalKey<State<StatefulWidget>> key_;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                // key: key_,
                onPressed: () async {
                  showToast('Play Audio Message of converted text');
                  print('Text is = $name');
                  await ref.read(homeProvider).playAudio(context, name);
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
