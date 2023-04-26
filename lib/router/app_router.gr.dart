// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:google_maps_flutter/google_maps_flutter.dart' as _i8;

import '../frontend/config/config.dart' as _i4;
import '../frontend/home/comonents/dialog.dart' as _i5;
import '../frontend/home/home.dart' as _i3;
import '../frontend/splash/splash.dart' as _i1;
import '../frontend/welcome/welcome.dart' as _i2;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.Splash(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.Welcome(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.Home(),
      );
    },
    ConfigRoute.name: (routeData) {
      final args = routeData.argsAs<ConfigRouteArgs>();
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.Config(
          key: args.key,
          locations: args.locations,
        ),
      );
    },
    MenuDialogRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.MenuDialog(),
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i6.RouteConfig(
          WelcomeRoute.name,
          path: '/Welcome',
        ),
        _i6.RouteConfig(
          HomeRoute.name,
          path: '/Home',
        ),
        _i6.RouteConfig(
          ConfigRoute.name,
          path: '/Config',
        ),
        _i6.RouteConfig(
          MenuDialogRoute.name,
          path: '/menu-dialog',
        ),
      ];
}

/// generated route for
/// [_i1.Splash]
class SplashRoute extends _i6.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.Welcome]
class WelcomeRoute extends _i6.PageRouteInfo<void> {
  const WelcomeRoute()
      : super(
          WelcomeRoute.name,
          path: '/Welcome',
        );

  static const String name = 'WelcomeRoute';
}

/// generated route for
/// [_i3.Home]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/Home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.Config]
class ConfigRoute extends _i6.PageRouteInfo<ConfigRouteArgs> {
  ConfigRoute({
    _i7.Key? key,
    required List<_i8.Marker> locations,
  }) : super(
          ConfigRoute.name,
          path: '/Config',
          args: ConfigRouteArgs(
            key: key,
            locations: locations,
          ),
        );

  static const String name = 'ConfigRoute';
}

class ConfigRouteArgs {
  const ConfigRouteArgs({
    this.key,
    required this.locations,
  });

  final _i7.Key? key;

  final List<_i8.Marker> locations;

  @override
  String toString() {
    return 'ConfigRouteArgs{key: $key, locations: $locations}';
  }
}

/// generated route for
/// [_i5.MenuDialog]
class MenuDialogRoute extends _i6.PageRouteInfo<void> {
  const MenuDialogRoute()
      : super(
          MenuDialogRoute.name,
          path: '/menu-dialog',
        );

  static const String name = 'MenuDialogRoute';
}
