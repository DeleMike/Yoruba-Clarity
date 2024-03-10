import 'package:chips_choice/chips_choice.dart';
import 'package:flexi_chip/flexi_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yoruba_clarity/configs/color_palette.dart';
import 'package:yoruba_clarity/core/dashboard/controllers/home_controller.dart';
import 'package:yoruba_clarity/core/dashboard/result/controllers/result_controller.dart';
import 'package:yoruba_clarity/widgets/yc_app_bar.dart';

import '../../../../boxes.dart';
import '../../../../configs/dimensions.dart';
import '../../../../widgets/a_chat_bubble.dart';
import '../../../../widgets/loading_screen.dart';
import '../../../local/flashcard.dart';
import '../../../local/label.dart';
import '../model/message.dart';

final labelsFutureProvider =
    FutureProvider.autoDispose<List<Label>>((ref) async {
  final resultsService = ref.watch(resultProvider);
  return resultsService.getExistingLabels();
});

class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key, required this.messages});

  final List<Message> messages;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultController = ref.watch(resultProvider);
    final labelsRef = ref.watch(labelsFutureProvider);
    final labels = ref.watch(resultProvider).labels;
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
            labelsRef.when(data: (labels) {
              if (labels.isEmpty) return Container();
              return ChipsChoice<String>.multiple(
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
                  source: labels.map((equipment) => equipment.name).toList(),
                  value: (i, v) => v,
                  label: (i, v) => v,
                ),
              );
            }, error: (error, s) {
              print('Error: $error, $s');
              return Container();
            }, loading: () {
              return const LoadingScreen();
            }),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            onTap: () async {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) => const Center(
                  child: LoadingScreen(),
                ),
              );
              await ref
                  .read(resultProvider)
                  .saveText(messages[1], ref.read(homeProvider))
                  .then(
                (value) async {
                  context.pop(); // remove dialog
                  context.pop(); // remove results
                },
              );
            },
            label: 'Save Word',
            child: const Icon(Icons.save_alt_rounded,
                color: ColorPalette.kPrimaryColor),
          ),
          SpeedDialChild(
            onTap: () async {
              
              await ref.read(resultProvider).playAudio(context, messages[1].content);

            },
            label: 'Listen',
            child: const Icon(Icons.play_arrow_rounded,
                color: ColorPalette.kPrimaryColor),
          ),
          SpeedDialChild(
            onTap: () {
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return const AlertDialog(
                    content: _AddLabel(),
                  );
                },
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

class _AddLabel extends ConsumerWidget {
  const _AddLabel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController labelController = TextEditingController();

    return Container(
      padding: EdgeInsets.all(20.0),
      height: kScreenHeight(context) * 0.4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Create a New Label',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height: 20.0),
          TextField(
            controller: labelController,
            decoration: const InputDecoration(
              labelText: 'Enter Label',
              border: UnderlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: kPaddingS, vertical: kPaddingM),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(kScreenWidth(context) * 0.4, 40),
                backgroundColor: ColorPalette.kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: () async {
                // Get the label text from the text field
                String labelText = labelController.text;
                print('Label Text: $labelText');
                ref.read(resultProvider).saveLabel(labelText.trim());

                // Close the bottom sheet
                context.pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Add new label',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: ColorPalette.kWhite),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
