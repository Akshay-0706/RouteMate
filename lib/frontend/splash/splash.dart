import 'package:flutter/material.dart';
import 'package:routing/frontend/splash/components/body.dart';
import 'package:routing/size.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig(context);
    return const Scaffold(
      body: SplashBody(),
    );
  }
}
