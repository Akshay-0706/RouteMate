import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:routing/backend/auth/auth.dart';
import 'package:routing/const.dart';
import 'package:routing/router/app_router.gr.dart';

import '../../../backend/auth/account.dart';
import '../../../global.dart';
import '../../../size.dart';
import '../../components/primary_btn.dart';

class WelcomeBody extends StatefulWidget {
  const WelcomeBody({super.key});

  @override
  State<WelcomeBody> createState() => _WelcomeBodyState();
}

class _WelcomeBodyState extends State<WelcomeBody> {
  FirebaseDatabase databaseRef = FirebaseDatabase.instance;
  // Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
  // late SharedPreferences pref;
  final box = GetStorage();
  bool signedIn = false, signin = false;

  @override
  void initState() {
    signedIn = box.read('signedIn') ?? false;
    // sharedPreferences.then((value) {
    //   pref = value;
    //   setState(() {
    //     prefIsReady = true;
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Pallete pallete = Pallete(context);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          const Spacer(),
          LottieBuilder.asset(
            "assets/extras/lottie_welcome.json",
            repeat: true,
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getHeight(20)),
            child: SizedBox(
              width: getWidth(220),
              child: Text(
                "We Need To Change Our Society",
                style: TextStyle(
                  color: pallete.primaryDark,
                  fontSize: getWidth(22),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getHeight(20)),
            child: Text(
              "Welcome to Split-it, with this app you can easily keep track of your expenses, split bills among your friends and stay in your budget!",
              style: TextStyle(
                color: pallete.primaryLight,
                fontSize: getWidth(14),
              ),
            ),
          ),
          SizedBox(height: getHeight(20)),
          if (!signin)
            PrimaryBtn(
              title: "Sign in with Google",
              primaryColor: pallete.primary,
              secondaryColor: pallete.primary.withOpacity(0.8),
              titleColor: Colors.white,
              padding: getWidth(20),
              hasIcon: true,
              tap: () {
                setState(() {
                  signin = true;
                });
                Auth.googleLogin().then((value) {
                  Account? user = value;
                  if (user != null) {
                    if (!signedIn || box.read('email') != user.email) {
                      box.write('name', user.name);
                      box.write('photo', user.photo);
                      box.write('email', user.email);
                      box.write('id', user.id);
                      box.write('signedIn', true);

                      // Database.setData(
                      //     databaseRef, user.email, user.name, user.photo);
                    }
                    // Navigator.pushReplacementNamed(context, "/screen");
                    appRouter.push(const HomeRoute());
                  } else {
                    setState(() {
                      signin = false;
                    });
                  }
                });
              },
            ),
          if (signin)
            Center(
              child: CircularProgressIndicator(
                color: pallete.primary,
              ),
            ),
          SizedBox(height: getHeight(60)),
        ],
      ),
    );
  }
}
