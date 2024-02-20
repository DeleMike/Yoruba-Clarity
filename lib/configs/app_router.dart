import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yoruba_clarity/core/dashboard/diacritize/screens/add_diacritics.dart';
import 'package:yoruba_clarity/core/dashboard/home_screen.dart';
import 'package:yoruba_clarity/core/dashboard/result/screens/result_screen.dart';
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
        path: resultScreen,
        builder: (BuildContext context, GoRouterState state) =>
            const ResultScreen(),
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const ResultScreen(),
        ),
      ),
    ],
    debugLogDiagnostics: kDebugMode ? true : false,
  );
}
