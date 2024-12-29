import 'package:flutter/cupertino.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({
    super.key,
    required this.app,
  });

  final AppInfo app;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        InstalledApps.startApp(app.packageName);
      },
      onLongPress: () {
        InstalledApps.openSettings(app.packageName);
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.memory(
            app.icon!,
            width: 55,
            height: 55,
          ),
        ),
      ),
    );
  }
}
