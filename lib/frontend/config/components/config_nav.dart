import 'package:flutter/material.dart';
import 'package:routing/size.dart';

import '../../../global.dart';

class ConfigNav extends StatelessWidget {
  const ConfigNav({
    Key? key,
    required this.onSubmitted,
    required this.readyToSubmit,
  }) : super(key: key);
  final bool readyToSubmit;
  final Function onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(8),
          child: AnimatedRotation(
            turns: 1 / 8,
            duration: const Duration(seconds: 1),
            child: Icon(
              Icons.add,
              color: Theme.of(context).primaryColorDark,
              size: getHeight(26),
            ),
          ),
        ),
        const Spacer(),
        Text(
          "Set Details",
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontSize: getHeight(20),
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () => readyToSubmit ? onSubmitted() : null,
          borderRadius: BorderRadius.circular(8),
          child: Icon(
            Icons.done,
            color: readyToSubmit
                ? Theme.of(context).primaryColorDark
                : Theme.of(context).primaryColorLight.withOpacity(0.5),
            size: getHeight(26),
          ),
        ),
      ],
    );
  }
}
