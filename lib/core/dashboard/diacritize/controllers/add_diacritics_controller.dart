import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yoruba_clarity/widgets/loading_screen.dart';
import 'package:http/http.dart' as http;
import 'package:yoruba_clarity/network/http_client.dart' as client;

import '../../../../configs/app_router.dart';
import '../../../../configs/constants.dart';
import '../../../../configs/debug_fns.dart';
import '../../result/model/message.dart';

final addDiacriticsProvider =
    ChangeNotifierProvider.autoDispose<AddDiacriticsController>((ref) {
  return AddDiacriticsController();
});

/// Its main job is to grab the text, validate it and
/// send to the endpoint and then get the response
class AddDiacriticsController with ChangeNotifier {
  final formData = {};

  Future<void> applyDiacritics({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
  }) async {
    String result = '';
    // get a reponse from a network
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      printOut('Data gotten from user is = $formData');

      try {
        showDialog(context: context, builder: (ctx) => const LoadingScreen());
        final payload = {"text": formData['text'].toString().trim()};
        printOut('Data to Send to server = ${jsonEncode(payload)}');
        final response = await client.HttpClient.instance.postResourceWithToken(
          resource: 'diacritize',
          data: jsonEncode(payload),
        ) as http.Response;

        navigatorKey.currentState!.pop(); // removing dialog

        if (response.statusCode == 200) {
          // showToast('There\'s an output');
          printOut('There\'s an output');
          printOut('Result is = ${jsonDecode(response.body)['result']}}');
          result = jsonDecode(response.body)['result'];
          printOut('Result after diacritics = $result');
          List<Message> messages = <Message>[
            Message.fromJson({
              'content': formData['text'].toString().trim(),
              'is_user': true,
            }),
            Message.fromJson({
              'content': result,
              'is_user': false,
            }),
          ];
          final args = {'messages': messages};
          if (context.mounted) {
            context.pushNamed(
              AppRouter.resultScreen.substring(1),
              extra: args,
            );
          }
        } else if (response.statusCode == 502) {
          // showToast('Restarting because of bad gateway');
          printOut('Restarting because of bad gateway...');
          if (context.mounted) {
            await applyDiacritics(context: context, formKey: formKey);
          }
        } else {
          showToast('Something went wrong');
          printOut('Something went wrong');
        }
      } on SocketException {
        showToast('Poor or no internet connection');
        printOut('Poor or no internet connection');
      } catch (e, s) {
        printOut('An error ocurred: $e, $s');
      }
    } else {
      printOut('Not valid');
    }
  }
}
