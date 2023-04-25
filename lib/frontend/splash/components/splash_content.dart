import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:routing/const.dart';

import '../../../size.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.opacity,
  }) : super(key: key);
  final double opacity;

  @override
  Widget build(BuildContext context) {
    Pallete pallete = Pallete(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: getWidth(120),
          height: getWidth(120),
          child: LottieBuilder.asset(
            "assets/extras/lottie_logo.json",
            repeat: true,
          ),
        ),
        SizedBox(height: getHeight(20)),
        Opacity(
          opacity: opacity,
          child: Text(
            "RouteMate",
            style: TextStyle(
              color: pallete.primaryDark,
              fontSize: getHeight(20),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
