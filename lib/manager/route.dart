import 'package:auto_route/annotations.dart';
import 'package:routing/frontend/home/home.dart';
import 'package:routing/frontend/splash/splash.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: Splash, initial: true),
  MaterialRoute(page: Home),
])
class $Route {}

// run command: flutter packages pub run build_runner watch