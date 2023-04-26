import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:routing/size.dart';

import '../../../global.dart';

class ConfigInfo extends StatelessWidget {
  const ConfigInfo({
    Key? key,
    required this.onChangedVehicles,
    required this.onChangedCapacity,
  }) : super(key: key);
  final Function onChangedVehicles, onChangedCapacity;

  @override
  Widget build(BuildContext context) {
    String reg = r'[0-9.]';
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getHeight(10)),
            child: TextFormField(
              style: TextStyle(color: Theme.of(context).primaryColorDark),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  onChangedVehicles(int.parse(value));
                } else {
                  onChangedVehicles(0);
                }
              },
              validator: (value) =>
                  int.tryParse(value!) == null ? "Invalid int" : null,
              inputFormatters: [
                // for below version 2 use this
                FilteringTextInputFormatter.allow(RegExp(reg)),
              ],
              keyboardType: TextInputType.number,
              cursorColor: Theme.of(context).primaryColor,
              cursorRadius: const Radius.circular(8),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "No of vehicles",
                hintStyle: TextStyle(
                    color: Theme.of(context).primaryColorLight.withOpacity(0.5),
                    fontSize: getHeight(16)),
              ),
            ),
          ),
        ),
        SizedBox(height: getHeight(20)),
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getHeight(10)),
            child: TextFormField(
              style: TextStyle(color: Theme.of(context).primaryColorDark),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  onChangedCapacity(double.parse(value));
                } else {
                  onChangedCapacity(0.0);
                }
              },
              validator: (value) =>
                  double.tryParse(value!) == null ? "Invalid double" : null,
              inputFormatters: [
                // for below version 2 use this
                FilteringTextInputFormatter.allow(RegExp(reg)),
              ],
              keyboardType: TextInputType.number,
              cursorColor: Theme.of(context).primaryColor,
              cursorRadius: const Radius.circular(8),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Capacity of vehicle",
                hintStyle: TextStyle(
                    color: Theme.of(context).primaryColorLight.withOpacity(0.5),
                    fontSize: getHeight(16)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
