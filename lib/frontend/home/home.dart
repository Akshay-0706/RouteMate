import 'dart:async';
import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routing/backend/algorithm/api.dart';
import 'package:routing/backend/maps/map_api.dart';
import 'package:routing/const.dart';
import 'package:routing/frontend/home/comonents/dialog.dart';
import 'package:routing/global.dart';
import 'package:routing/models/directions.dart';
import 'package:routing/models/distance_matrix.dart';
import 'package:routing/models/location.dart';
import 'package:routing/router/app_router.gr.dart';
import 'package:routing/size.dart';
import 'package:routing/utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Completer<GoogleMapController> _controller = Completer();

  late String mapStyleLight, mapStyleDark;
  final box = GetStorage();
  bool showingOutput = false;

  static const CameraPosition mumbai = CameraPosition(
    target: LatLng(19.0760, 72.8777),
    zoom: 15,
  );

  static StreamSubscription<DatabaseEvent>? subscription;

  static Map? dBResult;

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  List<Directions>? resultRoutes;
  static DatabaseReference ref = FirebaseDatabase.instance.ref('/Algorithm2');

  String getMarkerId() {
    return markers.length.toString();
  }

  String getPolylineId() {
    return 'polyline ${polylines.length + 1}';
  }

  void addMarker(LatLng argument) {
    markers.add(
      Marker(
        markerId: MarkerId(getMarkerId()),
        position: argument,
        draggable: true,
        icon: locationIcon,
      ),
    );
    log.d('markers length: ${markers.length}');
    setState(() {});
  }

  LatLng? getLatLongByMarkerId(int id) {
    LatLng? result;

    for (Marker element in markers) {
      if (element.markerId.value == id.toString()) {
        result = element.position;
      }
    }

    return result;
  }

  void getRoutes2(List r) {
    List<List<LatLng>> result = [];

    log.d(r.length);
    log.d(r.first?.length);

    for (int i = 0; i < r.length; i++) {
      List<LatLng> subresult = [];

      for (int j = 0; j < r[i].length; j++) {
        log.d(r[i][j]);
        LatLng? latLng = getLatLongByMarkerId(r[i][j]);

        if (latLng != null) {
          subresult.add(latLng);
        } else {
          log.d('Null');
        }
      }

      result.add(subresult);
    }

    resultRoutePoints = result;
  }

  void getRoutes(Map map, int k) {
    List<List<LatLng>> result = [];

    for (int i = 0; i < k; i++) {
      List<LatLng> subresult = [];

      for (int j = 0; j < map[i].length; j++) {
        LatLng? latLng = getLatLongByMarkerId(map[i][j]);

        if (latLng != null) {
          subresult.add(latLng);
        } else {
          log.d('Null');
        }
      }

      result.add(subresult);
    }

    resultRoutePoints = result;
  }

  bool inRange(LatLng latLng1, LatLng latLng2) {
    if ((latLng1.latitude - latLng2.latitude).abs() <= 0.0001 &&
        (latLng1.longitude - latLng2.longitude).abs() <= 0.0001) {
      return true;
    }
    return false;
  }

  void deleteMarker(LatLng latLng) {
    for (var marker in markers) {
      print(latLng.latitude);
      print(marker.position.latitude);
      if ((latLng.latitude - marker.position.latitude).abs() < 0.00001) {
        markers.remove(marker);
        break;
      }
    }
    // markers.removeWhere((element) => inRange(latLng, element.position));
    setState(() {});
  }

  void startSubscription() {
    subscription = ref.child('output').onValue.listen((event) {
      log.d('Data changed');
      log.d(event.snapshot.value);
      if (event.snapshot.value == null) return;
      dBResult = event.snapshot.value as Map;
      // log.d(dBResult!['k']);
      int key = dBResult!["key"];
      log.w("key generated: ${Constants.key}");
      log.w("key got: $key");
      // update result routes
      polylines.clear();
      resultRoutes = null;
      if (key == Constants.key) solveOutput();
    });
  }

  void stopSubscription() {
    if (subscription != null) subscription!.cancel();
  }

  @override
  void initState() {
    rootBundle.loadString('assets/extras/map_style_light.json').then((string) {
      mapStyleLight = string;
    }).catchError((error) => log.e(error));

    rootBundle.loadString('assets/extras/map_style_dark.json').then((string) {
      mapStyleDark = string;
    }).catchError((error) => log.e(error));

    startSubscription();

    super.initState();
  }

  void showMenuDialog(Pallete pallete) {
    AlertDialog menuDialog = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: const Color(0xFF00203A),
      title: Row(
        children: [
          Expanded(
            child: Text(
              "RouteMate",
              style: TextStyle(
                color: Colors.white,
                fontSize: getHeight(16),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          InkWell(
            onTap: () => appRouter.pop(),
            borderRadius: BorderRadius.circular(8),
            child: AnimatedRotation(
              turns: 1 / 8,
              duration: const Duration(seconds: 1),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: getHeight(26),
              ),
            ),
          ),
        ],
      ),
      content: MenuDialog(),
    );
    showDialog(context: context, builder: (context) => menuDialog);
  }

  Directions? resultRoute;

  List<List<LatLng>>? resultRoutePoints;

  @override
  Widget build(BuildContext context) {
    Pallete pallete = Pallete(context);
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 10, bottom: 10),
        child: FloatingActionButton(
          backgroundColor: themeChanger.isDarkMode
              ? Colors.white
              : const Color.fromARGB(255, 0, 85, 154),
          onPressed: () async {
            // setInput();
            appRouter
                .push(ConfigRoute(locations: markers.toList()))
                .then((value) {
              setState(() {
                showingOutput = value as bool;
              });
            });
          },
          child: Icon(
            Icons.play_arrow_rounded,
            color: themeChanger.isDarkMode
                ? const Color.fromARGB(255, 0, 85, 154)
                : Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            initialCameraPosition: mumbai,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              controller.setMapStyle(
                  themeChanger.isDarkMode ? mapStyleDark : mapStyleLight);
            },
            onTap: (LatLng argument) => addMarker(argument),
            markers: markers,
            polylines: polylines,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getWidth(20), vertical: getHeight(60)),
            child: Row(
              mainAxisAlignment: markers.isEmpty
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.spaceBetween,
              children: [
                if (markers.isNotEmpty || showingOutput)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (showingOutput) {
                          Constants.key = -1;
                          showingOutput = false;
                          markers.clear();
                          polylines.clear();
                          resultRoutes = null;
                        } else {
                          markers.remove(markers.last);
                        }
                      });
                    },
                    child: Container(
                      height: getWidth(40),
                      decoration: BoxDecoration(
                        color: themeChanger.isDarkMode
                            ? Colors.white
                            : const Color.fromARGB(255, 0, 85, 154),
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Icon(
                            showingOutput
                                ? Icons.restart_alt_rounded
                                : Icons.undo_rounded,
                            color: pallete.background,
                          ),
                        ),
                      ),
                    ),
                  ),
                GestureDetector(
                  onTap: () {
                    showMenuDialog(pallete);
                  },
                  child: Container(
                    height: getWidth(40),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: themeChanger.isDarkMode
                            ? Colors.white
                            : const Color.fromARGB(255, 0, 85, 154),
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(imageUrl: box.read("photo")),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void solveOutput() {
    if (dBResult == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No Output'),
        ),
      );
      return;
    }

    getRoutes2(dBResult!['routes']);

    solve();
  }

  void solve() async {
    for (List<LatLng> route in resultRoutePoints!) {
      log.d(route.toString());
      Directions? res = await MapApi.getDirectionsWithWayPoints(
        //start point
        route[0],
        //end point
        route[route.length - 1],
        // other points
        route.sublist(1, route.length - 1),
      );

      if (res == null) {
        log.d('Null');
      } else {
        log.d(res.polylinePoints.length);
      }

      resultRoutes ??= [];

      resultRoutes!.add(res!);
    }

    for (var i = 0; i < resultRoutes!.length; i++) {
      polylines.add(
        Polyline(
          polylineId: PolylineId(getPolylineId()),
          color: Constants.routeColors[i % Constants.routeColors.length],
          width: 4,
          points: resultRoutes![i]
              .polylinePoints
              .map((e) => LatLng(e.latitude, e.longitude))
              .toList(),
        ),
      );
    }

    setState(() {});
  }

  @override
  void dispose() {
    stopSubscription();
    super.dispose();
  }
}
