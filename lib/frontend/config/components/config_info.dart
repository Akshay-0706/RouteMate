import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:routing/size.dart';

import '../../../global.dart';

class ConfigInfo extends StatelessWidget {
  const ConfigInfo({
    Key? key,
    required this.onChangedBillName,
    required this.onChangedPrice,
  }) : super(key: key);
  final Function onChangedBillName, onChangedPrice;

  @override
  Widget build(BuildContext context) {
    String reg = r'[0-9.]';
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getHeight(10)),
              child: TextFormField(
                style: TextStyle(color: Theme.of(context).primaryColorDark),
                onChanged: (value) => onChangedBillName(value),
                keyboardType: TextInputType.text,
                cursorRadius: const Radius.circular(8),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "No of trucks",
                  hintStyle: TextStyle(
                      color:
                          Theme.of(context).primaryColorLight.withOpacity(0.5),
                      fontSize: getHeight(16)),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: getHeight(20)),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getHeight(10)),
              child: TextFormField(
                style: TextStyle(color: Theme.of(context).primaryColorDark),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    onChangedPrice(double.parse(value));
                  } else {
                    onChangedPrice(0.0);
                  }
                },
                validator: (value) =>
                    double.tryParse(value!) == null ? "Invalid double" : null,
                inputFormatters: [
                  // for below version 2 use this
                  FilteringTextInputFormatter.allow(RegExp(reg)),
                ],
                keyboardType: TextInputType.number,
                cursorRadius: const Radius.circular(8),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Price",
                  hintStyle: TextStyle(
                      color:
                          Theme.of(context).primaryColorLight.withOpacity(0.5),
                      fontSize: getHeight(16)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
