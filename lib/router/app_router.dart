// route management here

import 'package:auto_route/annotations.dart';
import 'package:routing/frontend/config/config.dart';
import 'package:routing/frontend/home/comonents/dialog.dart';
import 'package:routing/frontend/home/home.dart';
import 'package:routing/frontend/splash/splash.dart';
import 'package:routing/frontend/welcome/welcome.dart';

@MaterialAutoRouter(
  routes: [
    // add new routes here
    MaterialRoute(page: Splash, initial: true),
    MaterialRoute(page: Welcome),
    MaterialRoute(page: Home),
    MaterialRoute(page: Config),
    MaterialRoute(page: MenuDialog),
  ],
)
// do not edit this line
class $AppRouter {}

// run command: flutter packages pub run build_runner watch  --delete-conflicting-outputs