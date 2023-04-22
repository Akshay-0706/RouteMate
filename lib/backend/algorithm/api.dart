import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:routing/models/distance_matrix.dart';
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
}
