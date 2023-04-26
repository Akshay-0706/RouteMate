import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:routing/size.dart';

import '../../../global.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.capacity,
    required this.index,
    required this.color,
    required this.isEditing,
    required this.onChanged,
    required this.onSubmitted,
    required this.myFocus,
  }) : super(key: key);
  final Color color;
  final String title, subtitle;
  final int index;
  final double capacity;
  final bool isEditing;
  final Function onChanged, onSubmitted;
  final FocusNode myFocus;

  @override
  Widget build(BuildContext context) {
    String reg = r'[0-9.]';

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(getHeight(20)),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: getHeight(16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: TextStyle(
                      color:
                          Theme.of(context).primaryColorDark.withOpacity(0.7),
                      fontSize: getHeight(14),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
            const Spacer(),
            // Text(
            //   "\u{20B9} ",
            //   style: TextStyle(
            //     color: Theme.of(context).primaryColorDark,
            //     fontSize: getHeight(16),
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            if (!isEditing)
              Text(
                capacity.toStringAsFixed(2),
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: getHeight(16),
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (isEditing)
              SizedBox(
                width: getHeight(37),
                child: TextFormField(
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontWeight: FontWeight.bold,
                  ),
                  focusNode: index == 0 ? myFocus : null,
                  onChanged: (value) =>
                      onChanged(index, value == "" ? 0.0 : double.parse(value)),
                  onFieldSubmitted: (value) => onSubmitted(),
                  validator: (value) =>
                      double.tryParse(value!) == null ? "Invalid double" : null,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    // for below version 2 use this
                    FilteringTextInputFormatter.allow(RegExp(reg)),
                  ],
                  cursorColor: Theme.of(context).primaryColor,
                  cursorRadius: const Radius.circular(8),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintText: "0.00",
                    hintStyle: TextStyle(
                      color:
                          Theme.of(context).primaryColorLight.withOpacity(0.7),
                      fontSize: getHeight(16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
