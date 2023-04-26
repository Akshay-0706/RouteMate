import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routing/frontend/config/components/config_footer.dart';
import 'package:routing/frontend/config/components/config_info.dart';
import 'package:routing/frontend/config/components/config_nav.dart';
import 'package:routing/frontend/config/components/location_card.dart';
import 'package:routing/models/location.dart';
import 'package:routing/size.dart';

class ConfigBody extends StatefulWidget {
  ConfigBody({super.key, required this.locations});

  List<Marker> locations;

  @override
  State<ConfigBody> createState() => _ConfigBodyState();
}

class _ConfigBodyState extends State<ConfigBody> {
  String name = "";
  double amt = 0, willGet = 0, willPay = 0, paidByMe = 0, totalAmt = 0;
  bool isSource = true, isEditing = false;
  // int paidBy = -1;
  bool readyToSubmit = false;
  int source = -1, dest = -1;

  late final List<Marker> friends;
  List<double> amounts = [];

  final TextEditingController controller = TextEditingController();
  final FocusNode myFocus = FocusNode();
  final List<FocusNode> focusNode = [];

  void onChangedBillName(String name) {
    this.name = name;
    // validator();
  }

  void onChangedPrice(double amt) {
    setState(() {
      this.amt = amt;
    });
    // validator();
  }

  // void onFriendAdded(String name) {
  //   setState(() {
  //     friends.add(name);
  //     amounts.add(0.0);
  //     focusNode.add(FocusNode());
  //   });
  //   focusNode[focusNode.length - 1].requestFocus();
  //   validator();
  // }

  // void validator() {
  //   if (name.isNotEmpty && amt != 0 && friends.isNotEmpty) {
  //     if (isEditing) {
  //       if (totalAmt == amt) {
  //         setState(() {
  //           readyToSubmit = true;
  //         });
  //       } else {
  //         setState(() {
  //           readyToSubmit = false;
  //         });
  //       }
  //     } else {
  //       setState(() {
  //         readyToSubmit = true;
  //       });
  //     }
  //   } else {
  //     setState(() {
  //       readyToSubmit = false;
  //     });
  //   }
  // }

  void onAmtChanged(int index, double value) {
    //TODO
    setState(() {
      // if (index == -1) {
      //   totalAmt -= paidByMe;
      //   paidByMe = value;
      //   totalAmt += paidByMe;
      // } else {
      totalAmt -= amounts[index];
      amounts[index] = value;
      totalAmt += amounts[index];
      // }
    });
    // validator();
  }

  @override
  void initState() {
    friends = widget.locations;

    for (int i = 0; i < friends.length; i++) {
      amounts.add(30);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(getHeight(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ConfigNav(readyToSubmit: readyToSubmit, onSubmitted: () {}),
            SizedBox(height: getHeight(40)),
            ConfigInfo(
              onChangedBillName: onChangedBillName,
              onChangedPrice: onChangedPrice,
            ),
            SizedBox(height: getHeight(20)),
            Text(
              "Select source and destination",
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize: getHeight(18),
                fontWeight: FontWeight.bold,
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
                  controller: controller,
                  style: TextStyle(color: Theme.of(context).primaryColorDark),
                  // onFieldSubmitted: (value) {
                  //   if (value.isNotEmpty) {
                  //     onFriendAdded(value);
                  //     controller.text = "";
                  //   }
                  // },
                  keyboardType: TextInputType.text,
                  cursorRadius: const Radius.circular(8),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Friend's name",
                    hintStyle: TextStyle(
                        color: Theme.of(context)
                            .primaryColorLight
                            .withOpacity(0.5),
                        fontSize: getHeight(16)),
                  ),
                ),
              ),
            ),
            SizedBox(height: getHeight(20)),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isSource = !isSource;
                    });
                  },
                  child: Icon(
                    isSource ? Icons.check_box : Icons.check_box_outline_blank,
                    color: Theme.of(context).primaryColorDark,
                    size: getHeight(20),
                  ),
                ),
                SizedBox(width: getHeight(10)),
                Text(
                  "Source/Destination",
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: getHeight(14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                SizedBox(width: getHeight(20)),
                InkWell(
                  onTap: () {
                    setState(() {
                      isEditing = !isEditing;
                      if (isEditing) {
                        myFocus.requestFocus();
                        // validator();
                      }
                    });
                  },
                  child: Icon(
                    isEditing ? Icons.check_box : Icons.check_box_outline_blank,
                    color: Theme.of(context).primaryColorDark,
                    size: getHeight(20),
                  ),
                ),
                SizedBox(width: getHeight(10)),
                Text(
                  "Edit Capacity",
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: getHeight(14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: getHeight(20)),
            // InkWell(
            //   onTap: () {},
            //   borderRadius: BorderRadius.circular(8),
            //   child: LocationCard(
            //     name: "Me",
            //     amount: isEditing ? paidByMe : amt / (friends.length + 1),
            //     isEditing: isEditing,
            //     focusNode: myFocus,
            //     onSubmitted: () {
            //       if (focusNode.isNotEmpty) {
            //         focusNode[0].requestFocus();
            //       }
            //     },
            //     onChanged: onAmtChanged,
            //     color: Colors.yellow,
            //     // color: paidBy == -1
            //     //     ? Theme.of(context).primaryColor.withOpacity(0.5)
            //     //     : Theme.of(context).primaryColorDark.withOpacity(0.05),
            //     index: -1,
            //   ),
            // ),
            SizedBox(height: getHeight(10)),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ...List.generate(
                      friends.length,
                      (index) => Column(
                        children: [
                          InkWell(
                            onTap: () {
                              // if (!isSource && paidBy != index) {
                              //   setState(() {
                              //     paidBy = index;
                              //   });
                              // } else {
                              //   setState(() {
                              //     isSource = false;
                              //     paidBy = index;
                              //   });
                              // }

                              if (isSource && dest != index) {
                                source = index;
                              }

                              if (!isSource && source != index) {
                                dest = index;
                              }
                              setState(() {});
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: LocationCard(
                              name: source == index
                                  ? 'Location $index (Source)'
                                  : dest == index
                                      ? 'Location  $index (Dest)'
                                      : 'Location $index',
                              isEditing: isEditing,
                              onChanged: onAmtChanged,
                              capacity:
                                  isEditing ? 30 : amt / (friends.length + 1),
                              // color: Colors.red,
                              color: source == index
                                  ? Colors.red
                                  : dest == index
                                      ? Colors.green
                                      : Theme.of(context)
                                          .primaryColorDark
                                          .withOpacity(0.05),
                              onSubmitted: () {
                                if (index < friends.length - 1) {
                                  // focusNode[index + 1].requestFocus();
                                }
                              },
                              index: index,
                            ),
                          ),
                          if (index != friends.length - 1)
                            SizedBox(height: getHeight(10)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: getHeight(20)),
            ConfigFooter(
              isEditing: isEditing,
              amt: amt,
              totalAmt: totalAmt,
            ),
          ],
        ),
      ),
    ));
  }
}
