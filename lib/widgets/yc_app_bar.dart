import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yoruba_clarity/configs/color_palette.dart';

class YCAppBar extends StatelessWidget implements PreferredSizeWidget {
  const YCAppBar(
      {super.key, required this.headerText, required this.needsABackButton});
  final String headerText;
  final bool needsABackButton;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ClipRRect(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: AppBar(
              backgroundColor:
                  ColorPalette.kDeepTextColor, //color ?? kCanvasColor, // kRed
              surfaceTintColor: ColorPalette.kWhite,
              elevation: 0,
              iconTheme: const IconThemeData(
                color: ColorPalette.kWhite,
              ),
              centerTitle: true,
              title: Text(
                headerText,
                maxLines: 1,
                overflow: TextOverflow.fade,
                softWrap: true,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ColorPalette.kWhite,
                    ),
              ),
              leading: needsABackButton
                  ? IconButton(
                      // perform normal back button press if there is no custom function given
                      onPressed: () => context.pop(), //Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: ColorPalette.kWhite,
                        size: 16,
                      ))
                  : null,
            ),
          ),
        ],
      ),
    ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
