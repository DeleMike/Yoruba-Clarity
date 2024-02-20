import 'package:flutter/material.dart';
import 'package:yoruba_clarity/core/dashboard/home_screen.dart';
import 'package:yoruba_clarity/core/onboarding/onboarding.dart';
import 'package:yoruba_clarity/widgets/loading_screen.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  late Future _initializer;

  /// initialize properties needed before user has access
  /// Check if user has viewed the app once
  /// If no, show onboarding else, go to home
  _init() async {}

  @override
  void initState() {
    super.initState();
    _initializer = _init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializer,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: LoadingScreen());
        }
        return const OnboardingScreen();
      },
    );
  }
}
