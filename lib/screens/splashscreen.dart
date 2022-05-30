import 'package:easy_economy/screens/home.dart';
import 'package:easy_economy/style/pallete.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SplashScreen(
          loadingText: Text(
            "Desenvolvido por João Victor Morais ",
            style: TextStyle(fontSize: 14, color: Pallete().whiteText),
          ),
          seconds: 3,
          gradientBackground: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Pallete().primary, Pallete().primaryLight]),
          navigateAfterSeconds: Home(),
          loaderColor: Pallete().secondary,
        ),
        Align(
          alignment: FractionalOffset.center,
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/transparent_icon.png"),
                    fit: BoxFit.scaleDown)),
          ),
        )
      ],
    );
  }
}
