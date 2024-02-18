import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const spinkit = SpinKitFadingCircle(
      color: Colors.white,
      size: 50.0,
    );
    return const Center(
      child: spinkit,
    );
  }
}
