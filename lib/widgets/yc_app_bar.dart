import 'package:flutter/material.dart';
import 'package:yoruba_clarity/configs/color_palette.dart';

class YCAppBar extends StatelessWidget implements PreferredSizeWidget {
  const YCAppBar({super.key, required this.headerText});
  final String headerText;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        headerText,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: ColorPalette.kWhite,
            ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
