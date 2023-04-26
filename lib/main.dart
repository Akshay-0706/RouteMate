import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routing/const.dart';
import 'package:routing/theme.dart';
import 'package:routing/utils.dart';
import 'firebase_options.dart';
import 'global.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: "assets/extras/.env");
  Constants.MAP_API_KEY = dotenv.env['MAP_API_KEY']!;

  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  locationIcon = await BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(
      size: Size(5, 5),
    ),
    "assets/icons/location.png",
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final box = GetStorage();

  @override
  void initState() {
    themeChanger.isDarkMode = themeChanger.currentTheme() == ThemeMode.system
        ? WidgetsBinding.instance.window.platformBrightness == Brightness.dark
        : themeChanger.currentTheme() == ThemeMode.dark;

    final window = WidgetsBinding.instance.window;

    if (box.read("theme") == "Light") {
      themeChanger.changeThemeMode("Light");
    }

    if (box.read("theme") == "Dark") {
      themeChanger.changeThemeMode("Dark");
    }

    window.onPlatformBrightnessChanged = () {
      setState(() {
        themeChanger.isDarkMode =
            themeChanger.currentTheme() == ThemeMode.system
                ? WidgetsBinding.instance.window.platformBrightness ==
                    Brightness.dark
                : themeChanger.currentTheme() == ThemeMode.dark;
      });

      if (themeChanger.theme == "Auto") {
        setState(() {
          themeChanger.changeThemeMode("Auto");
        });
      }
    };

    themeChanger.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // changed to material app router
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'RouteMate',
      theme: NewTheme.lightTheme(),
      darkTheme: NewTheme.darkTheme(),
      themeMode: themeChanger.currentTheme(),
      // added this two lines for auto route
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}
