import 'package:device_apps/device_apps.dart';

class AppService {
  static List<ApplicationWithIcon> _apps = [];

  static Future<void> init() async {
    List<dynamic> apps = await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeSystemApps: true,
      includeAppIcons: true,
    );
    _apps = apps.cast<ApplicationWithIcon>();
  }

  static List<ApplicationWithIcon> get allApps => _apps;
}
