import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:routing/const.dart';

import '../../../size.dart';

class SigninTexts extends StatelessWidget {
  const SigninTexts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Pallete pallete = Pallete(context);
    return AnimatedTextKit(
      repeatForever: true,
      animatedTexts: [
        TypewriterAnimatedText(
          "Auto login...",
          textStyle: TextStyle(
            color: pallete.background,
            fontSize: getHeight(18),
            fontWeight: FontWeight.bold,
          ),
          speed: const Duration(milliseconds: 100),
          cursor: "",
        ),
        TypewriterAnimatedText(
          "Please wait few seconds...",
          textStyle: TextStyle(
            color: pallete.background,
            fontSize: getHeight(18),
            fontWeight: FontWeight.bold,
          ),
          speed: const Duration(milliseconds: 100),
          cursor: "",
        ),
        TypewriterAnimatedText(
          "Signing you in...",
          textStyle: TextStyle(
            color: pallete.background,
            fontSize: getHeight(18),
            fontWeight: FontWeight.bold,
          ),
          speed: const Duration(milliseconds: 100),
          cursor: "",
        ),
        TypewriterAnimatedText(
          "Check your internet...",
          textStyle: TextStyle(
            color: pallete.background,
            fontSize: getHeight(18),
            fontWeight: FontWeight.bold,
          ),
          speed: const Duration(milliseconds: 100),
          cursor: "",
        ),
      ],
    );
  }
}