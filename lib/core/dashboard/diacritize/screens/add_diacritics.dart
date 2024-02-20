import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yoruba_clarity/configs/app_router.dart';
import 'package:yoruba_clarity/widgets/yc_app_bar.dart';

import '../../../../configs/color_palette.dart';
import '../../../../configs/debug_fns.dart';
import '../../../../configs/dimensions.dart';

class AddDiacritics extends StatefulWidget {
  const AddDiacritics({super.key});

  @override
  State<AddDiacritics> createState() => _AddDiacriticsState();
}

class _AddDiacriticsState extends State<AddDiacritics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const YCAppBar(headerText: 'Add Diacritics', needsABackButton: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kPaddingM, horizontal: kPaddingS),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                key: const ValueKey('yor_text'),
                keyboardType: TextInputType.text,
                minLines: 1,
                maxLines: 10,
                style: const TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  labelText: 'Enter Yorùbá phrase/sentence?',
                  labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: ColorPalette.kBlueThreeVariantColor,
                      fontWeight: FontWeight.w800),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorPalette.kPrimaryColor)),
                  filled: false,
                  fillColor: ColorPalette.kGrey.withOpacity(0.3),
                  isDense: true,
                  contentPadding: const EdgeInsets.all(40),
                ),
                cursorColor: ColorPalette.kPrimaryColor,
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'You cannot send an empty text';
                  }

                  return null;
                },
                onSaved: (value) {
                  if (value != null) {
                  } else {
                    printOut('Tried entering an empty text');
                  }
                },
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
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
                      context.push(AppRouter.resultScreen);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Apply Diacritics',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: ColorPalette.kWhite),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
