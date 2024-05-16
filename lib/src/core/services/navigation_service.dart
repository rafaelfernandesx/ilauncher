import 'package:flutter/widgets.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._();
  NavigationService._();
  factory NavigationService() => NavigationService._instance;

  final _navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic> navigateToAndRemoveUntil(
    String routeName,
    String defaultBackRouteName, {
    dynamic arguments,
  }) {
    return _navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      ModalRoute.withName(defaultBackRouteName),
      arguments: arguments,
    );
  }

  Future<dynamic> navigateToAndRemoveUntilModal(String routeName) {
    return _navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => route.isFirst,
    );
  }

  Future<dynamic> navigateReplacement(
    String routeName, {
    dynamic arguments,
  }) {
    return _navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);
  }

  void popUntil(String routeName) {
    _navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }

  void pop({dynamic result}) {
    _navigatorKey.currentState!.pop(result);
  }
}
