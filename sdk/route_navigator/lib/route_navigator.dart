library route_navigator;

import 'package:flutter/material.dart';

class RouteNavigator {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @optionalTypeArgs
  Future<T?> pushScreen<T extends Object>(
    String routeName, {
    Object? arguments,
    GlobalKey<NavigatorState>? key,
  }) {
    dynamic response = (key ?? navigatorKey).currentState!.pushNamed(
          routeName,
          arguments: arguments,
        );
    return response;
  }

  @optionalTypeArgs
  Future<bool> pop<T extends Object>({
    GlobalKey<NavigatorState>? key,
    T? result,
  }) async {
    return await (key ?? navigatorKey).currentState!.maybePop(result);
  }

  @optionalTypeArgs
  Future<T?> pushReplacementScreen<T extends Object, TO extends Object>(
    String routeName, {
    TO? result,
    Object? arguments,
    GlobalKey<NavigatorState>? key,
  }) {
    dynamic response = (key ?? navigatorKey).currentState!.pushReplacementNamed(
          routeName,
          arguments: arguments,
          result: result,
        );
    return response;
  }

  @optionalTypeArgs
  Future<T?> pushScreenAndRemoveUntil<T extends Object, TO extends Object>(
    String routeName, {
    TO? result,
    Object? arguments,
    GlobalKey<NavigatorState>? key,
  }) {
    dynamic response = (key ?? navigatorKey).currentState!.pushNamedAndRemoveUntil(
          routeName,
          (route) => false,
          arguments: arguments,
        );

    return response;
  }

  void popUntil(
    String routeName, {
    GlobalKey<NavigatorState>? key,
  }) {
    (key ?? navigatorKey).currentState!.popUntil(ModalRoute.withName(routeName));
  }

  BuildContext getContext() {
    return navigatorKey.currentState!.overlay!.context;
  }

  bool get isMounted => navigatorKey.currentState?.overlay?.context != null;
}
