import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yoruba_clarity/core/local/flashcard.dart';
import 'package:yoruba_clarity/widgets/yc_app_bar.dart';

import '../../configs/color_palette.dart';
import '../../configs/constants.dart';
import '../../configs/dimensions.dart';
import '../../widgets/confirmation_dialog.dart';
import 'controllers/home_controller.dart';

class ViewScreen extends ConsumerWidget {
  const ViewScreen({super.key, required this.flashcard});

  final Flashcard flashcard;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeController = ref.read(homeProvider);
    return Scaffold(
      appBar: const YCAppBar(
        headerText: 'View Yorùbá Text',
        needsABackButton: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(kPaddingS),
        width: double.infinity,
        child: Card(
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: ColorPalette.kBorderGrey,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(kSmallRadius),
            ),
          ),
          elevation: 0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          surfaceTintColor: ColorPalette.kWhite,
          color: ColorPalette.kWhite,
          child: Padding(
            padding: const EdgeInsets.all(kPaddingS),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SelectableText(
                  flashcard.content,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: ColorPalette.kPrimaryColor, fontSize: 18),
                ),
                SizedBox(height: kScreenHeight(context) * 0.025),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(kPaddingM),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(40),
                            ),
                            border: Border.all(
                                width: 0.6, color: ColorPalette.kBorderGrey),
                          ),
                          child: IconButton(
                            // key: key_,
                            onPressed: () async {
                              showToast('Play Audio Message of converted text');
                              print('Text is = ${flashcard.content}');
                              await ref
                                  .read(homeProvider)
                                  .playAudio(context, flashcard.content);
                            },
                            icon: const Icon(Icons.play_arrow_rounded),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(40),
                            ),
                            border: Border.all(
                                width: 0.6, color: ColorPalette.kBorderGrey),
                          ),
                          child: IconButton(
                            // key: key_,
                            onPressed: () async {
                              bool willDelete = await showConfirmationDialog(
                                  context,
                                  'Do you really want to delete is card?');

                              if (willDelete) {
                                print('user will delete');
                                await ref.read(homeProvider).deleteText(context, flashcard);
                              } else {
                                print('user does not want to delete');
                              }

                            },
                            icon: const Icon(Icons.delete_forever),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
