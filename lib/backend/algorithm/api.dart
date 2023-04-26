import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:routing/models/distance_matrix.dart';
import 'package:routing/models/location.dart';
import 'package:routing/utils.dart';

class API {
  static DatabaseReference ref = FirebaseDatabase.instance.ref('/Algorithm2');

  static Future<void> addData(DistanceMatrix distanceMatrix) async {
    log.d('Adding data to firebase');
    try {
      await ref.set(distanceMatrix.toJson());
    } on Exception catch (e) {
      log.d(e.toString());
    }
  }

  static Future<void> addSourceDest(
      Location src, Location dest, DistanceMatrix res) async {
    log.d('Adding src data');

    try {
      await ref
          .child('input')
          .child('endpoints')
          .child('source')
          .set(src.toJson());
      await ref
          .child('input')
          .child('endpoints')
          .child('destination')
          .set(dest.toJson());

      Map<String, dynamic> distances = <String, dynamic>{};

      for (int i = 0; i < res.rows!.first.elements!.length; i++) {
        distances['$i'] = res.rows!.first.elements![i].distance!.value;
      }

      await ref
          .child('input')
          .child('endpoints')
          .child('source')
          .child('distances')
          .set(distances);
    } on Exception catch (e) {
      log.d(e.toString());
    }
  }
}
