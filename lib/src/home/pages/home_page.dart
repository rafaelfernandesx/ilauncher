import 'dart:ui';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rlauncher/src/core/services/app_service.dart';
import 'package:rlauncher/src/core/settings/settings.dart';

import '../../core/services/fullscreen_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 1, vsync: this);
    FullscreenService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: CupertinoPageScaffold(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Settings.getWallpaperPath),
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.center,
          child: SafeArea(
            top: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    physics: const BouncingScrollPhysics(),
                    dragStartBehavior: DragStartBehavior.down,
                    children: const [
                      // Add your widgets here
                      Text('Home Page'),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  margin: const EdgeInsets.all(15),
                  // decoration: BoxDecoration(
                  //   color: Colors.grey.withOpacity(0.1),
                  //   borderRadius: const BorderRadius.all(Radius.circular(30)),
                  // ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        color: Colors.grey.withOpacity(0.1),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                DeviceApps.openApp(AppService.allApps[0].packageName);
                              },
                              onLongPress: () {
                                DeviceApps.openAppSettings(AppService.allApps[0].packageName);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.memory(AppService.allApps[0].icon, width: 60, height: 60),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
