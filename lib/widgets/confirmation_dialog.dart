import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yoruba_clarity/configs/color_palette.dart';


/// shows dialog to prompt user's about logout event
Future<bool> showConfirmationDialog(
    BuildContext context, String message) async {
  var performAction = false;
  await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            'Yorùbá Clarity',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          content: Text(
            message,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorPalette.kPrimaryColor),
              child: Text(
                'NO',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: ColorPalette.kWhite, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                performAction = false;
                context.pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: ColorPalette.kPrimaryColor),
              onPressed: () {
                performAction = true;
                context.pop();
              },
              child: Text(
                'YES',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: ColorPalette.kPrimaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      });

  return performAction;
}
