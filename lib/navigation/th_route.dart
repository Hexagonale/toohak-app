import 'package:fluro/fluro.dart';

class ThRoute {
  const ThRoute({
    required this.route,
    required this.handler,
  });

  final String route;
  final Handler handler;
}
