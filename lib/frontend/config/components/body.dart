import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routing/backend/algorithm/api.dart';
import 'package:routing/backend/maps/map_api.dart';
import 'package:routing/const.dart';
import 'package:routing/frontend/config/components/config_footer.dart';
import 'package:routing/frontend/config/components/config_info.dart';
import 'package:routing/frontend/config/components/config_nav.dart';
import 'package:routing/frontend/config/components/location_card.dart';
import 'package:routing/global.dart';
import 'package:routing/models/distance_matrix.dart';
import 'package:routing/models/location.dart';
import 'package:routing/size.dart';
import 'package:routing/utils.dart';
import 'dart:math' as math;

class ConfigBody extends StatefulWidget {
  const ConfigBody({super.key, required this.locations});

  final List<Marker> locations;

  @override
  State<ConfigBody> createState() => _ConfigBodyState();
}

class _ConfigBodyState extends State<ConfigBody> {
  int vehicles = 0, variance = 0;
  double vehicleCap = 0, sourceCap = 0.0, destCap = 0.0, totalCap = 0.0;
  bool isSource = true,
      isSourceSelected = false,
      isDestSelected = false,
      isUnequal = false,
      allCapAreNonZero = true;
  bool readyToSubmit = false;
  int source = -1, dest = -1;

  late final List<Marker> locations;
  List<double> capacities = [];

  final FocusNode myFocus = FocusNode();
  final List<FocusNode> focusNode = [];

  void onChangedVehicles(int vehicles) {
    this.vehicles = vehicles;
    validator();
  }

  void onChangedCapacity(double vehicleCap) {
    setState(() {
      this.vehicleCap = vehicleCap;
    });
    validator();
  }

  void onChangedVariance(int variance) {
    this.variance = variance;
    validator();
  }

  void validator() {
    setState(() {
      readyToSubmit = vehicles != 0 &&
          vehicleCap != 0 &&
          variance != 0 &&
          totalCap != 0 &&
          isSourceSelected &&
          isDestSelected &&
          allCapAreNonZero;
    });
  }

  void onAmtChanged(int index, double value) {
    setState(() {
      totalCap -= capacities[index];
      capacities[index] = value;
      totalCap += capacities[index];
      allCapAreNonZero = true;
      for (var capacity in capacities) {
        if (capacity == 0) allCapAreNonZero = false;
      }
    });
    validator();
  }

  @override
  void initState() {
    locations = widget.locations;
    totalCap = 30.0 * locations.length;

    for (int i = 0; i < locations.length; i++) {
      capacities.add(0.0);
    }
    super.initState();
  }

  Future<void> onSubmitted() async {
    print('hello called');
    log.d('hello called');
    // final distanceMatrix = DistanceMatrix.fromJson(
    //     jsonDecode(DistanceMatrix.sampleResponse));
    Marker sourceMarker = locations[source];
    Marker destMarker = locations[dest];

    final List<LatLng> allLocations = [];

    locations.remove(sourceMarker);
    locations.remove(destMarker);

    sourceCap = capacities[source];
    destCap = capacities[dest];

    if (source < dest) {
      capacities.removeAt(source);
      capacities.removeAt(dest - 1);
    } else {
      capacities.removeAt(source);
      capacities.removeAt(dest);
    }

    Constants.noOfTrucks = vehicles;
    Constants.truckCapacity = vehicleCap;
    Constants.variance = variance;
    Constants.key = math.Random().nextInt(100);

    for (int i = 0; i < locations.length; i++) {
      Marker element = locations.elementAt(i);
      allLocations
          .add(LatLng(element.position.latitude, element.position.longitude));
    }

    final DistanceMatrix? res1 = await MapApi.getDistances(
      //origins
      allLocations,
      //destinations
      allLocations,
    );

    if (res1 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error fetching distances'),
        ),
      );
      return;
    }

    for (int i = 0; i < locations.length; i++) {
      Marker marker = locations.elementAt(i);

      res1.locations.add(
        Location(
          latitude: marker.position.latitude,
          longitude: marker.position.longitude,
          name: res1.destinationAddresses![i],
          id: int.parse(marker.markerId.value),
          cap: capacities[i] == 0 ? 30 : capacities[i],
        ),
      );
    }

    log.d(res1.rows!.length);

    await API.addData(res1);

    final DistanceMatrix? res2 = await MapApi.getDistances(
      //origins
      // [LatLng(19.09, 72.89)],
      [LatLng(sourceMarker.position.latitude, sourceMarker.position.longitude)],
      //destinations
      allLocations,
    );

    if (res2 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error fetching distances'),
        ),
      );
      return;
    }

    await API.addSourceDest(
        Location(
          latitude: sourceMarker.position.latitude,
          longitude: sourceMarker.position.longitude,
          name: "Source",
          id: source,
          cap: sourceCap == 0 ? 30 : sourceCap,
        ),
        Location(
          latitude: destMarker.position.latitude,
          longitude: destMarker.position.longitude,
          name: "Destination",
          id: dest,
          cap: destCap == 0 ? 30 : destCap,
        ),
        res2);
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
            ConfigNav(
                readyToSubmit: readyToSubmit,
                onSubmitted: () {
                  onSubmitted();
                  appRouter.pop(true);
                }),
            SizedBox(height: getHeight(40)),
            ConfigInfo(
              onChangedVehicles: onChangedVehicles,
              onChangedCapacity: onChangedCapacity,
              onChangedVariance: onChangedVariance,
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
                Row(
                  children: [
                    Text(
                      "Source",
                      style: TextStyle(
                        color: isSource
                            ? Theme.of(context).primaryColorDark
                            : Theme.of(context)
                                .primaryColorLight
                                .withOpacity(0.5),
                        fontSize: getHeight(14),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "/",
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: getHeight(14),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Destination",
                      style: TextStyle(
                        color: isSource
                            ? Theme.of(context)
                                .primaryColorLight
                                .withOpacity(0.5)
                            : Theme.of(context).primaryColorDark,
                        fontSize: getHeight(14),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(width: getHeight(20)),
                InkWell(
                  onTap: () {
                    setState(() {
                      isUnequal = !isUnequal;
                      if (isUnequal) {
                        totalCap = 0.0;
                        allCapAreNonZero = false;
                        for (int i = 0; i < locations.length; i++) {
                          capacities[i] = 0.0;
                        }
                        myFocus.requestFocus();
                        validator();
                      } else {
                        totalCap = 30.0 * locations.length;
                        allCapAreNonZero = true;
                      }
                    });
                  },
                  child: Icon(
                    isUnequal ? Icons.check_box : Icons.check_box_outline_blank,
                    color: Theme.of(context).primaryColorDark,
                    size: getHeight(20),
                  ),
                ),
                SizedBox(width: getHeight(10)),
                Text(
                  "Edit capacity",
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: getHeight(14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: getHeight(20)),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ...List.generate(
                      locations.length,
                      (index) => Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (isSource && dest != index) {
                                source = index;
                                isSourceSelected = true;
                              }

                              if (!isSource && source != index) {
                                dest = index;
                                isDestSelected = true;
                              }

                              setState(() {
                                validator();
                              });
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: LocationCard(
                              title: 'Location $index',
                              subtitle: source == index
                                  ? "Source"
                                  : dest == index
                                      ? "Destination"
                                      : "",
                              myFocus: myFocus,
                              isEditing: isUnequal,
                              onChanged: onAmtChanged,
                              capacity: isUnequal ? totalCap : 30,
                              // color: Colors.red,
                              color: source == index
                                  ? Theme.of(context).primaryColor
                                  : dest == index
                                      ? Colors.green
                                      : Theme.of(context)
                                          .primaryColorDark
                                          .withOpacity(0.05),
                              onSubmitted: () {
                                if (index < locations.length - 1) {
                                  // focusNode[index + 1].requestFocus();
                                }
                              },
                              index: index,
                            ),
                          ),
                          if (index != locations.length - 1)
                            SizedBox(height: getHeight(10)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: getHeight(20)),
            ConfigFooter(totalCap: totalCap),
          ],
        ),
      ),
    ));
  }
}
