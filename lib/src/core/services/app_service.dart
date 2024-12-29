import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

class AppService {
  static List<AppInfo> _apps = [];

  static Future<void> init() async {
    final List<AppInfo> apps = await InstalledApps.getInstalledApps(
      true,
      true,
      // onlyAppsWithLaunchIntent: true,
      // includeSystemApps: true,
      // includeAppIcons: true,
    );
    _apps = apps;
  }

  static List<AppInfo> get allApps => _apps;

  static List<List<AppInfo>> get getAppsPaged {
    final listApp = _apps.fold<List<List<AppInfo>>>([], (previousValue, element) {
      if (previousValue.isEmpty) {
        previousValue.add([element]);
        return previousValue;
      }
      for (final item in previousValue) {
        if (item.length < 24) {
          previousValue[previousValue.indexOf(item)].add(element);
          return previousValue;
        }
      }
      previousValue.add([element]);
      return previousValue;
    });
    return listApp;
  }
}
