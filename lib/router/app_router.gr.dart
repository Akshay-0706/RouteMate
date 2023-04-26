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
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:google_maps_flutter/google_maps_flutter.dart' as _i7;

import '../frontend/config/config.dart' as _i4;
import '../frontend/home/home.dart' as _i3;
import '../frontend/splash/splash.dart' as _i1;
import '../frontend/welcome/welcome.dart' as _i2;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.Splash(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.Welcome(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.Home(),
      );
    },
    ConfigRoute.name: (routeData) {
      final args = routeData.argsAs<ConfigRouteArgs>();
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.Config(
          key: args.key,
          locations: args.locations,
        ),
      );
    },
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i5.RouteConfig(
          WelcomeRoute.name,
          path: '/Welcome',
        ),
        _i5.RouteConfig(
          HomeRoute.name,
          path: '/Home',
        ),
        _i5.RouteConfig(
          ConfigRoute.name,
          path: '/Config',
        ),
      ];
}

/// generated route for
/// [_i1.Splash]
class SplashRoute extends _i5.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.Welcome]
class WelcomeRoute extends _i5.PageRouteInfo<void> {
  const WelcomeRoute()
      : super(
          WelcomeRoute.name,
          path: '/Welcome',
        );

  static const String name = 'WelcomeRoute';
}

/// generated route for
/// [_i3.Home]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/Home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.Config]
class ConfigRoute extends _i5.PageRouteInfo<ConfigRouteArgs> {
  ConfigRoute({
    _i6.Key? key,
    required List<_i7.Marker> locations,
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

  final _i6.Key? key;

  final List<_i7.Marker> locations;

  @override
  String toString() {
    return 'ConfigRouteArgs{key: $key, locations: $locations}';
  }
}
