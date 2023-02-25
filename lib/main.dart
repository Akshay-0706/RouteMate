import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:routing/theme.dart';
import 'firebase_options.dart';
import 'global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
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
      title: 'Vehicle Routing',
      theme: NewTheme.lightTheme(),
      darkTheme: NewTheme.darkTheme(),
      themeMode: themeChanger.currentTheme(),
      // added this two lines for auto route
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}
