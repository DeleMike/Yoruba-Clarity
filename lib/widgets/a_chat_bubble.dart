import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:yoruba_clarity/configs/assets.dart';
import 'package:yoruba_clarity/configs/color_palette.dart';
import 'package:yoruba_clarity/core/dashboard/result/model/message.dart';

import '../configs/dimensions.dart';

/// displays component for chatting space
class ChatBubble extends StatelessWidget {
  /// displays component for chatting space
  ChatBubble({super.key});

  final messages = <Message>[
    Message.fromJson({
      'content': 'mo fe jeun',
      'is_user': true,
    }),
    Message.fromJson({
      'content': 'mo fẹ́ jẹun',
      'is_user': false,
    }),
  ];

  @override
  Widget build(BuildContext context) {
    return GroupedListView<Message, DateTime>(
      reverse: true,
      elements: messages.reversed.toList(),

      groupBy: (Message message) => DateTime
          .now(), // to group all the chats at once, since the chat room is a one time thing
      groupHeaderBuilder: (Message message) =>
          SizedBox(height: kScreenHeight(context) * 0.02),
      itemBuilder: (context, Message message) => Align(
        alignment:
            message.isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!message.isUser)
              SizedBox(
                width: 20,
                height: 20,
                child: Image.asset(AssetsImages.botImage),
              ),
            Bubble(
              nipWidth: kPaddingS,
              nipHeight: kPaddingS - 4,
              nip:
                  message.isUser ? BubbleNip.rightBottom : BubbleNip.leftBottom,
              color: message.isUser
                  ? ColorPalette.kLightPrimaryColor
                  : ColorPalette.kPrimaryColor,
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(kPaddingS),
                child: Theme(
                  data: ThemeData(
                    textSelectionTheme: TextSelectionThemeData(
                      selectionColor:
                          message.isUser ? null : ColorPalette.kAccentColor,
                      selectionHandleColor: message.isUser
                          ? ColorPalette.kRed
                          : ColorPalette.kAccentColor,
                    ),
                  ),
                  child: SelectableText(
                    message.content,
                    style: message.isUser
                        ? Theme.of(context).textTheme.bodyMedium
                        : Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: ColorPalette.kWhite),
                    scrollPhysics: const ClampingScrollPhysics(),
                  ),
                ),
              ),
            ),
            if (message.isUser)
              SizedBox(
                width: 20,
                height: 20,
                child: Image.asset(AssetsImages.userImage),
              ),
          ],
        ),
      ),
    );
  }
}
