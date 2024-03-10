import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yoruba_clarity/core/dashboard/diacritize/screens/add_diacritics.dart';
import 'package:yoruba_clarity/core/dashboard/home_screen.dart';
import 'package:yoruba_clarity/core/dashboard/result/screens/result_screen.dart';
import 'package:yoruba_clarity/core/dashboard/view_screen.dart';
import 'package:yoruba_clarity/core/onboarding/onboarding.dart';

import '../core/init_screen.dart';
import 'constants.dart';
import 'custom_page_transitions.dart';

class AppRouter {
  /// initial screen
  static const initialScreen = '/';

  static const onboardingScreen = '/onboarding';

  static const homeScreen = '/home';

  static const addDiacriticsScreen = '/add-diacritics';

  static const resultScreen = '/result-screen';

  static const viewScreen = '/view-screen';

  static final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: initialScreen,
    routes: <RouteBase>[
      GoRoute(
        path: initialScreen,
        builder: (BuildContext context, GoRouterState state) =>
            const InitScreen(),
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const InitScreen(),
        ),
      ),
      GoRoute(
        path: onboardingScreen,
        builder: (BuildContext context, GoRouterState state) =>
            const OnboardingScreen(),
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const OnboardingScreen(),
        ),
      ),
      GoRoute(
        path: homeScreen,
        builder: (BuildContext context, GoRouterState state) =>
            const HomeScreen(),
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        path: addDiacriticsScreen,
        builder: (BuildContext context, GoRouterState state) =>
            const AddDiacritics(),
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const AddDiacritics(),
        ),
      ),
      GoRoute(
        name: resultScreen.substring(1),
        path: resultScreen,
        builder: (BuildContext context, GoRouterState state) {
          final arguments = state.extra as Map;

          final messages = arguments['messages'];
          return ResultScreen(messages: messages);
        },
        pageBuilder: (context, state) {
          final arguments = state.extra as Map;

          final messages = arguments['messages'];

          return buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: ResultScreen(messages: messages),
          );
        },
      ),
      GoRoute(
        name: viewScreen.substring(1),
        path: viewScreen,
        builder: (BuildContext context, GoRouterState state) {
          final arguments = state.extra as Map;

          final yorText = arguments['flashcard'];
          return ViewScreen(flashcard: yorText);
        },
        pageBuilder: (context, state) {
          final arguments = state.extra as Map;

          final yorText = arguments['flashcard'];
          return buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: ViewScreen(flashcard: yorText),
          );
        },
      ),
    ],
    debugLogDiagnostics: kDebugMode ? true : false,
  );
}
