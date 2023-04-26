import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:routing/backend/auth/auth.dart';
import 'package:routing/const.dart';
import 'package:routing/global.dart';
import 'package:share_plus/share_plus.dart';
import 'package:routing/frontend/components/custom_page_route.dart';
import 'package:routing/frontend/welcome/welcome.dart';
import 'package:routing/size.dart';

class MenuDialog extends StatefulWidget {
  const MenuDialog({super.key});

  @override
  State<MenuDialog> createState() => _MenuDialogState();
}

class _MenuDialogState extends State<MenuDialog> {
  final box = GetStorage();
  List<String> themes = ["Light", "Dark", "Auto"];
  String theme = themeChanger.theme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(10)),
            child: Row(
              children: [
                SizedBox(
                  height: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(imageUrl: box.read("photo")),
                  ),
                ),
                SizedBox(width: getWidth(10)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      box.read("name"),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: getHeight(12),
                      ),
                    ),
                    Text(
                      box.read("email"),
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: getHeight(10),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: getHeight(30)),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getWidth(10), vertical: getHeight(10)),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/theme.svg",
                    color: Colors.white,
                    width: 20,
                  ),
                  SizedBox(width: getWidth(20)),
                  Text(
                    "Theme",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: getHeight(12),
                    ),
                  ),
                  const Spacer(),
                  CustomDropdownButton2(
                    hint: theme,
                    value: theme,
                    // textColor: Colors.white,
                    hintAlignment: Alignment.center,
                    valueAlignment: Alignment.center,
                    buttonWidth: getHeight(60),
                    buttonPadding: EdgeInsets.zero,
                    buttonHeight: getHeight(25),
                    dropdownWidth: getHeight(60),
                    dropdownItems: themes,
                    iconEnabledColor: Colors.white,
                    buttonDecoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    dropdownDecoration: BoxDecoration(
                      color: const Color(0xFF00203A),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    icon: const FaIcon(Icons.arrow_drop_down_rounded),
                    iconSize: getHeight(20),
                    onChanged: (value) {
                      setState(() {
                        theme = value!;
                        themeChanger.changeThemeMode(theme);
                        themeChanger.isDarkMode =
                            themeChanger.currentTheme() == ThemeMode.system
                                ? WidgetsBinding
                                        .instance.window.platformBrightness ==
                                    Brightness.dark
                                : themeChanger.currentTheme() == ThemeMode.dark;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Share.share(
                  "Hey! look what I found, RouteMate - the ultimate route optimization app for your business! Tired of spending hours manually finding the best route for you work? Let RouteMate do the work for you. With RouteMate, you can optimize your routes in just seconds, saving you time and money. Our app takes into account multiple factors like traffic, distance, and delivery windows to give you the most efficient and cost-effective routes possible. Plus, you can easily adjust routes on the go if changes arise. Say goodbye to inefficient routes and wasted time. Upgrade to RouteMate today and start optimizing your deliveries like a pro! Download now from the App Store or Google Play Store.");
            },
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getWidth(10), vertical: getHeight(10)),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/share.svg",
                    color: Colors.white,
                    width: 20,
                  ),
                  SizedBox(width: getWidth(20)),
                  Text(
                    "Share",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: getHeight(12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Auth.googleLogout();
              Navigator.pushReplacement(
                context,
                CustomPageRoute(
                  context,
                  const Welcome(),
                ),
              );
            },
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getWidth(10), vertical: getHeight(10)),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/logout.svg",
                    color: Colors.white,
                    width: 20,
                  ),
                  SizedBox(width: getWidth(20)),
                  Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: getHeight(12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: getHeight(20)),
        ],
      ),
    );
  }
}
