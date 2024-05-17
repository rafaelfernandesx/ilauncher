import 'package:flutter/cupertino.dart';

import '../core/services/navigation_service.dart';
import 'pages/settings_page.dart';

Map<String, Widget Function(BuildContext)> settingsRoutes = {
  '/settings': (context) {
    return const SettingsPage();
  },
};

class SettingsRoutes {
  static void pushSettings() {
    NavigationService().navigateTo('/settings');
  }
}
