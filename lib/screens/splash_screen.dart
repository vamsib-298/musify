/*import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(children: [
        Expanded(
          child: Image.asset(
            'assets/images/musicfly.png',
            width: 200,
            height: 200,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          'Welcome To Musify',
          style: TextStyle(
              fontSize: 22, color: Color.fromARGB(255, 233, 236, 239)),
        )
      ]),
      splashIconSize: 300,
      splashTransition: SplashTransition.scaleTransition,
      backgroundColor: Colors.black26,
      duration: 3000,
      pageTransitionType: PageTransitionType.bottomToTop,
        nextScreen:
    );
  }
}
*/