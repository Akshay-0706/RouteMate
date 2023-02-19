import 'package:flutter/material.dart';
import 'package:routing/backend/auth/auth.dart';
import 'package:routing/const.dart';
import 'package:routing/router/app_router.gr.dart';

import '../../../global.dart';
import '../../../size.dart';
import 'signin_texts.dart';

class SigninDialog extends StatelessWidget {
  const SigninDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Pallete pallete = Pallete(context);
    return FutureBuilder(
      future: Auth.googleLogin().then((value) {
        // Navigator.pushReplacementNamed(context, "/screen");
        appRouter.push(const HomeRoute());
      }),
      builder: (context, snapshot) {
        return Dialog(
          elevation: 2,
          child: Container(
            height: getHeight(120),
            decoration: BoxDecoration(
              color: pallete.primaryDark,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [SigninTexts()],
                ),
                CircularProgressIndicator(
                  color: pallete.background,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
