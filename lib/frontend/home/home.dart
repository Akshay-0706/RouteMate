import 'dart:async';

import 'package:flutter/material.dart';
import 'package:routing/frontend/home/comonents/body.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeBody(),
    );
  }
}
