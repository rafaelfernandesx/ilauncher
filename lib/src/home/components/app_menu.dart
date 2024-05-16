import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({
    super.key,
    required this.app,
  });

  final ApplicationWithIcon app;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DeviceApps.openApp(app.packageName);
      },
      onLongPress: () {
        DeviceApps.openAppSettings(app.packageName);
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.memory(
            app.icon,
            width: 55,
            height: 55,
          ),
        ),
      ),
    );
  }
}
