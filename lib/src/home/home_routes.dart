import 'package:flutter/cupertino.dart';

import '../core/services/navigation_service.dart';
import 'pages/home_page.dart';

Map<String, Widget Function(BuildContext)> homeRoutes = {
  '/home': (context) {
    return const HomePage();
  },
};

class HomeRoutes {
  static Future<void> pushReplacementHome() async {
    await NavigationService().navigateReplacement('/home');
  }

  static void pushHome() {
    NavigationService().navigateTo('/home');
  }

  static void popUntilHome() {
    NavigationService().popUntil('/home');
  }
}
