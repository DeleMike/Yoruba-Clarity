import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:yoruba_clarity/configs/app_router.dart';
import 'package:yoruba_clarity/configs/color_palette.dart';
import 'package:yoruba_clarity/configs/debug_fns.dart';

import '../../configs/assets.dart';
import '../../configs/constants.dart';
import '../../configs/dimensions.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();

  @override
  void initState() {
    super.initState();
  }

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorPalette.kPrimaryColor,
        body: PageView(
          controller: _controller,
          onPageChanged: (pageNo) {
            if (pageNo == 3) {
              isLast = true;
            } else {
              isLast = false;
            }
            printOut('Page no= $pageNo');

            _navigateOnboardingExperience(pageNo);
            setState(() {});
          },
          children: const [
            // first page
            _View(
              animPath: AssetsAnimations.firstAnim,
              viewName: 'Èdè Yorùbá.',
              tagLine: 'Diacritze, listen and learn!',
            ),

            //second page
            _View(
              animPath: AssetsAnimations.secondAnim,
              viewName: 'Àmì Ohùn.',
              tagLine:
                  'Diacritics are tonal marks that can serve as semantic distinguishers.',
            ),

            //third page
            _View(
              animPath: AssetsAnimations.thirdAnim,
              viewName: 'Ṣè o gbọ́.',
              tagLine: 'Listen to audio pronunciations.',
            ),

            //fourth page
            _View(
              animPath: AssetsAnimations.fourthAnim,
              viewName: 'Mọ íwé.',
              tagLine: 'Save, Learn and Repeat.',
            ),
          ],
        ),
        bottomSheet: Container(
          height: kScreenHeight(context) * 0.10,
          color: ColorPalette.kLightPrimaryColor,
          padding: const EdgeInsets.all(kPaddingS),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmoothPageIndicator(
                controller: _controller,
                count: 4,
                effect: ExpandingDotsEffect(
                  spacing: 16,
                  radius: 16,
                  dotHeight: 8,
                  dotWidth: 8,
                  dotColor: ColorPalette.kPrimaryColor.withOpacity(0.3),
                  activeDotColor: ColorPalette.kPrimaryColor,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorPalette.kPrimaryColor,
                  shape: const CircleBorder(),
                ),
                onPressed: () {
                  isLast
                      ? context.go(AppRouter.homeScreen)
                      : _navigateOnboardingExperience();
                },
                child: Center(
                    child: Icon(
                  isLast ? Icons.done : Icons.arrow_forward,
                  color: ColorPalette.kWhite,
                )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _navigateOnboardingExperience([int position = -1]) {
    if (_controller.page == 3.0) {
      _controller.animateToPage(0,
          duration: const Duration(milliseconds: 600), curve: Curves.easeInOut);
    } else if (position > -1 && position < 4) {
      _controller.animateToPage(position,
          duration: const Duration(milliseconds: 600), curve: Curves.easeInOut);
    } else {
      _controller.nextPage(
          duration: const Duration(milliseconds: 600), curve: Curves.easeInOut);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// General Top View for Onboarding
class _View extends StatelessWidget {
  final String animPath;
  final String viewName;
  final String tagLine;

  /// General Top View for Onboarding
  const _View(
      {required this.animPath, required this.viewName, required this.tagLine});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorPalette.kPrimaryColor,
      child: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            CircleAvatar(
              radius: 120,
              backgroundColor: ColorPalette.kTransparent,
              child: Lottie.asset(animPath),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(
                  left: kPaddingS + 2,
                  right: kPaddingM + 2,
                  top: 2,
                  bottom: kPaddingS - 5),
              child: Text(
                viewName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: kFontFamily,
                    fontWeight: FontWeight.w600,
                    fontSize: 33,
                    color: ColorPalette.kWhite),
              ),
            ),
            const Spacer(),
            Text(tagLine,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: ColorPalette.kWhite, fontSize: 14)),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
