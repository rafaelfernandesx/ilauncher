import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'src/core/services/app_service.dart';
import 'src/core/services/navigation_service.dart';
import 'src/core/services/persist_service.dart';
import 'src/core/settings/settings.dart';
import 'src/home/home_routes.dart';
import 'src/home/pages/home_page.dart';
import 'src/settings/settings_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Persist.init();
  await AppService.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Settings.getBrightness,
      builder: (_, state, __) {
        return CupertinoApp(
          title: 'iOS Launcher',
          debugShowCheckedModeBanner: false,
          theme: CupertinoThemeData(
            barBackgroundColor: CupertinoTheme.of(context).barBackgroundColor,
            applyThemeToAll: true,
            brightness: Settings.getBrightness.value,
            primaryColor: CupertinoTheme.of(context).primaryColor,
            scaffoldBackgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
            primaryContrastingColor: CupertinoTheme.of(context).primaryContrastingColor,
            // textTheme: const CupertinoTextThemeData(
            //   textStyle: TextStyle(color: Colors.black),
            // ),
          ),
          initialRoute: '/home',
          navigatorKey: NavigationService().navigatorKey,
          home: const HomePage(),
          routes: {
            ...homeRoutes,
            ...settingsRoutes,
          },
        );
      },
    );
  }
}
/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final appSM = ValueNotifier<List<ApplicationWithIcon>>([]);
  late final TabController _tabController = TabController(length: 4, vsync: this);

  Future<List<ApplicationWithIcon>> _getAppList() async {
    final List<dynamic> apps = await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeSystemApps: true,
      includeAppIcons: true,
    );
    return apps.cast();
  }

  @override
  void initState() {
    _getAppList().then((value) => appSM.value = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Settings.getWallpaperPath),
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).padding.top,
                width: 120,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: appSM,
                  builder: (_, state, __) {
                    final listAppsPage = state.fold<List<List<ApplicationWithIcon>>>([], (previousValue, element) {
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
                    final firstPage = listAppsPage.isNotEmpty ? listAppsPage[0] : [] as List<ApplicationWithIcon>;
                    final secondPage = listAppsPage.length > 1 ? listAppsPage[1] : [] as List<ApplicationWithIcon>;
                    final thirdPage = listAppsPage.length > 2 ? listAppsPage[2] : [] as List<ApplicationWithIcon>;
                    final fourthPage = state;

                    //retorne a lista de aplicativos em grid com imagem em cima e nome em baixo 4x5 usando tabbar
                    if (state.length > 10) {
                      return TabBarView(
                        controller: _tabController,
                        physics: const BouncingScrollPhysics(),
                        dragStartBehavior: DragStartBehavior.down,
                        children: [
                          GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: firstPage.length,
                            itemBuilder: (_, index) {
                              return GestureDetector(
                                onTap: () {
                                  DeviceApps.openApp(firstPage[index].packageName);
                                },
                                onLongPress: () {
                                  DeviceApps.openAppSettings(firstPage[index].packageName);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xAAFFFFFF),
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(14),
                                          child: Image.memory(firstPage[index].icon, width: 60, height: 60),
                                        ),
                                      ),
                                      Text(
                                        firstPage[index].appName,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          overflow: TextOverflow.ellipsis,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black,
                                              offset: Offset(1, 1),
                                              blurRadius: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                            ),
                            itemCount: secondPage.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              return GestureDetector(
                                onTap: () {
                                  DeviceApps.openApp(secondPage[index].packageName);
                                },
                                onLongPress: () {
                                  DeviceApps.openAppSettings(secondPage[index].packageName);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xAAFFFFFF),
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(14),
                                          child: Image.memory(secondPage[index].icon, width: 60, height: 60),
                                        ),
                                      ),
                                      Text(
                                        secondPage[index].appName,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          overflow: TextOverflow.ellipsis,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black,
                                              offset: Offset(1, 1),
                                              blurRadius: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                            ),
                            itemCount: thirdPage.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              return GestureDetector(
                                onTap: () {
                                  DeviceApps.openApp(thirdPage[index].packageName);
                                },
                                onLongPress: () {
                                  DeviceApps.openAppSettings(thirdPage[index].packageName);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xAAFFFFFF),
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(14),
                                          child: Image.memory(thirdPage[index].icon, width: 60, height: 60),
                                        ),
                                      ),
                                      Text(
                                        thirdPage[index].appName,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          overflow: TextOverflow.ellipsis,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black,
                                              offset: Offset(1, 1),
                                              blurRadius: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                            ),
                            itemCount: fourthPage.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              return GestureDetector(
                                onTap: () {
                                  DeviceApps.openApp(fourthPage[index].packageName);
                                },
                                onLongPress: () {
                                  DeviceApps.openAppSettings(fourthPage[index].packageName);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xAAFFFFFF),
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(14),
                                          child: Image.memory(fourthPage[index].icon, width: 60, height: 60),
                                        ),
                                      ),
                                      Text(
                                        fourthPage[index].appName,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          overflow: TextOverflow.ellipsis,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black,
                                              offset: Offset(1, 1),
                                              blurRadius: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }

                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      itemCount: state.length,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {
                            DeviceApps.openApp(state[index].packageName);
                          },
                          onLongPress: () {
                            DeviceApps.openAppSettings(state[index].packageName);
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xAAFFFFFF),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.memory(state[index].icon, width: 60, height: 60),
                                ),
                              ),
                              Text(
                                state[index].appName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  overflow: TextOverflow.ellipsis,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black,
                                      offset: Offset(1, 1),
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0x55000000),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    margin: const EdgeInsets.only(bottom: 15, top: 30),
                    child: const Row(
                      children: [
                        Icon(Icons.search, size: 18, color: Colors.white),
                        Text(
                          'Buscar',
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 100,
                margin: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
                decoration: const BoxDecoration(
                  color: Color(0x90FFFFFF),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: ValueListenableBuilder(
                  valueListenable: appSM,
                  builder: (_, state, __) {
                    if (state.length > 4) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              DeviceApps.openApp(state[0].packageName);
                            },
                            onLongPress: () {
                              DeviceApps.openAppSettings(state[0].packageName);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.memory(state[0].icon, width: 60, height: 60),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              DeviceApps.openApp(state[1].packageName);
                            },
                            onLongPress: () {
                              DeviceApps.openAppSettings(state[1].packageName);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.memory(state[1].icon, width: 60, height: 60),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              DeviceApps.openApp(state[2].packageName);
                            },
                            onLongPress: () {
                              DeviceApps.openAppSettings(state[2].packageName);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.memory(state[2].icon, width: 60, height: 60),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              DeviceApps.openApp(state[3].packageName);
                            },
                            onLongPress: () {
                              DeviceApps.openAppSettings(state[3].packageName);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.memory(state[3].icon, width: 60, height: 60),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/