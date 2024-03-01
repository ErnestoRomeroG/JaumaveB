import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mave/paginas/home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  get splash => null;

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Center(
            child: LottieBuilder.asset("lib/images/nature man darkmode.json"),
          )
        ],
      ),
      nextScreen: HomePage(),
      splashIconSize: 400,
      backgroundColor: Color.fromARGB(255, 218, 189, 252),
    );
  }
}
