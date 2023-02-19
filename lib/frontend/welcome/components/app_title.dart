import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:routing/const.dart';

import '../../../size.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Pallete pallete = Pallete(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/icons/logo.svg"),
        SizedBox(width: getWidth(10)),
        Text(
          "Vehicle Routing",
          style: TextStyle(
            color: pallete.primaryDark,
            fontSize: getWidth(24),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
