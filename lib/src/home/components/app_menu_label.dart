import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

class AppMenuLabel extends StatelessWidget {
  const AppMenuLabel({
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
        width: 75,
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
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
            const SizedBox(height: 5),
            Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(61, 0, 0, 0),
                    offset: Offset(0, 0),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Text(
                app.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
