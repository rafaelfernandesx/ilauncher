import 'package:device_apps/device_apps.dart';

class AppService {
  static List<ApplicationWithIcon> _apps = [];

  static Future<void> init() async {
    final List<dynamic> apps = await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeSystemApps: true,
      includeAppIcons: true,
    );
    _apps = apps.cast<ApplicationWithIcon>();
  }

  static List<ApplicationWithIcon> get allApps => _apps;

  static List<List<ApplicationWithIcon>> get getAppsPaged {
    final listApp = _apps.fold<List<List<ApplicationWithIcon>>>([], (previousValue, element) {
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
