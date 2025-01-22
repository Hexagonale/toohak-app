import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toohak/_toohak.dart';

final ThRouter thRouter = ThRouter.instance;

class ThRouter {
  static ThRouter get instance => sl<ThRouter>();

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final Logger _logger = Logger('ThRouter');
  final FluroRouter router = FluroRouter();

  void init(List<ThRoute> routes) {
    for (final ThRoute route in routes) {
      router.define(
        route.route,
        handler: route.handler,
        transitionType: TransitionType.cupertino,
      );
    }
  }

  void pop<T extends Object?>([T? result]) {
    navigatorKey.currentState?.pop(result);
  }

  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) async {
    _logger.routeChange('Routing to $routeName');

    return navigatorKey.currentState?.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<T?> replace<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) async {
    _logger.routeChange('Routing to $routeName');

    return navigatorKey.currentState?.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<void> removeAllAndPush(String routeName) async {
    _logger.routeChange('Routing to $routeName');

    await navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      (_) => false,
    );
  }
}
