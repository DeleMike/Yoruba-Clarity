import 'package:chips_choice/chips_choice.dart';
import 'package:flexi_chip/flexi_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:yoruba_clarity/configs/color_palette.dart';
import 'package:yoruba_clarity/core/dashboard/result/controllers/result_controller.dart';
import 'package:yoruba_clarity/widgets/yc_app_bar.dart';

import '../../../../configs/dimensions.dart';
import '../../../../widgets/a_chat_bubble.dart';
import '../../../../widgets/loading_screen.dart';
import '../model/message.dart';

class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key, required this.messages});

  final List<Message> messages;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultController = ref.watch(resultProvider);
    return Scaffold(
      appBar: const YCAppBar(
          headerText: 'Listen to Diacritized Text', needsABackButton: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kPaddingM, horizontal: kPaddingS),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: kPaddingS, right: kPaddingS, bottom: kPaddingS),
                child: ChatBubble(messages: messages),
              ),
            ),
            const Divider(
              color: ColorPalette.kPrimaryColor,
            ),
            const Padding(
              padding: EdgeInsets.all(kPaddingS),
              child: Text('Choose Label'),
            ),
            ChipsChoice<String>.multiple(
              value: resultController.labels,
              onChanged: (val) {
                ref.read(resultProvider.notifier).setTagValue(val);
              },
              choiceStyle: FlexiChipStyle.toned(
                backgroundColor: ColorPalette.kDeepTextColor,
              ),
              wrapped: true,
              choiceCheckmark: true,
              choiceItems: C2Choice.listFrom<String, String>(
                source: ['Hard Words', 'Easy', 'School', 'Work', 'Church'],
                value: (i, v) => v,
                label: (i, v) => v,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) => const Center(
                  child: LoadingScreen(),
                ),
              );
            },
            label: 'Save Word',
            child: const Icon(Icons.save_alt_rounded,
                color: ColorPalette.kPrimaryColor),
          ),
          SpeedDialChild(
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) => const Center(
                  child: LoadingScreen(),
                ),
              );
            },
            label: 'Listen',
            child: const Icon(Icons.play_arrow_rounded,
                color: ColorPalette.kPrimaryColor),
          ),
          SpeedDialChild(
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) => const Center(
                  child: LoadingScreen(),
                ),
              );
            },
            label: 'Add Label',
            child: const Icon(Icons.label, color: ColorPalette.kPrimaryColor),
          ),
        ],
      ),
    );
  }
}
