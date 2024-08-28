import 'package:flutter/material.dart';
import 'package:monitoring/models/base_event.dart';
import 'package:monitoring/tracker.dart';

import 'package:needle/needle.dart';

final GetIt _sl = GetIt.instance;

class UnicodeNavigatorObserver extends RouteObserver<PageRoute<dynamic>> {
  late DateTime _startTime;

  DateTime getNow() => DateTime.now();

  UnicodeNavigatorObserver() {
    _startTime = getNow();
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      trackMovement(
        route,
        previousRoute,
        'push',
      );
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      trackMovement(
        newRoute,
        oldRoute,
        'replace',
      );
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      trackMovement(
        previousRoute,
        route,
        'pop',
      );
    }
  }

  void trackMovement(Route<dynamic>? nextRoute, Route<dynamic>? prevRoute, String action) {
    int duration = getNow().difference(_startTime).inSeconds;

    Map<String, dynamic> params = {
      'duration': duration,
      'from_screen': prevRoute?.settings.name,
      'to_screen': nextRoute?.settings.name,
      'action': action,
    };

    _sl<Tracker>().track(BaseEvent(
      name: 'route_navigation',
      params: params,
    ));

    _startTime = getNow();
  }
}
