import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:installed_apps/installed_apps.dart';

import '../../core/services/app_service.dart';
import '../../core/services/fullscreen_service.dart';
import '../../core/settings/settings.dart';
import '../../settings/settings_routes.dart';
import '../components/app_menu.dart';
import '../components/app_menu_label.dart';
import '../components/custom_app_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: AppService.getAppsPaged.length, vsync: this);
    FullscreenService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Settings.getWallpaperPath),
            fit: BoxFit.cover,
          ),
        ),
        child: CupertinoPageScaffold(
          backgroundColor: Colors.transparent,
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.center,
            fit: StackFit.loose,
            children: [
              ShaderMask(
                shaderCallback: (rect) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Colors.transparent],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.colorBurn,
                child: SizedBox(
                  height: 120 + MediaQuery.of(context).padding.top,
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 36.5 + MediaQuery.of(context).padding.top),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: TabBarView(
                        controller: _tabController,
                        physics: const BouncingScrollPhysics(),
                        dragStartBehavior: DragStartBehavior.down,
                        children: [
                          ...AppService.getAppsPaged.map(
                            (listApp) => Wrap(
                              alignment: WrapAlignment.spaceEvenly,
                              runSpacing: 8.5,
                              children: [
                                ...listApp.map(
                                  (app) => AppMenuLabel(app: app),
                                ),
                                CustomAppMenu(
                                  onTap: SettingsRoutes.pushSettings,
                                  onLongPress: () => InstalledApps.openSettings(
                                    'com.rfx.ilauncher',
                                  ),
                                  svgPath: 'assets/icons/svg/settings-icon.svg',
                                  label: 'Ajustes',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50.7),
                  Container(
                    width: 65,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const CupertinoSearchTextField(
                      placeholder: 'Buscar',
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      padding: EdgeInsets.only(left: 3),
                      placeholderStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 2),
                        child: Icon(
                          CupertinoIcons.search,
                          color: Colors.grey,
                          size: 10,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    height: 89,
                    margin: const EdgeInsets.only(left: 9, right: 9, bottom: 13),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            AppMenu(app: AppService.allApps[0]),
                            AppMenu(app: AppService.allApps[1]),
                            AppMenu(app: AppService.allApps[2]),
                            AppMenu(app: AppService.allApps[3]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
