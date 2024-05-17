import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../core/settings/settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: CupertinoTheme.of(context).barBackgroundColor,
        statusBarIconBrightness: CupertinoTheme.of(context).brightness == Brightness.light ? Brightness.dark : Brightness.light,
        // statusBarBrightness: CupertinoTheme.of(context).brightness,
        // systemStatusBarContrastEnforced: true,
      ),
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        // navigationBar: const CupertinoNavigationBar(
        //   middle: Text('Ajustes'),
        // ),
        child: SafeArea(
          top: true,
          child: CustomScrollView(
            slivers: [
              const CupertinoSliverNavigationBar(
                largeTitle: Text('Ajustes'),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CupertinoListSection.insetGrouped(
                        children: [
                          CupertinoFormRow(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            prefix: Row(
                              children: [
                                const Icon(CupertinoIcons.person_crop_circle_fill, size: 60, color: CupertinoColors.systemGrey),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Rafael Fernandes', style: CupertinoTheme.of(context).textTheme.textStyle),
                                    Text('ID Apple, iCloud+, Mídia e Compras', style: CupertinoTheme.of(context).textTheme.tabLabelTextStyle),
                                  ],
                                ),
                              ],
                            ),
                            child: const Icon(CupertinoIcons.chevron_right, size: 15, color: CupertinoColors.systemGrey),
                          ),
                        ],
                      ),
                      CupertinoListSection.insetGrouped(
                        children: [
                          CupertinoFormRow(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            prefix: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: CupertinoColors.systemOrange,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Icon(CupertinoIcons.airplane, size: 20, color: CupertinoColors.white),
                                ),
                                const SizedBox(width: 10),
                                Text('Modo Avião', style: CupertinoTheme.of(context).textTheme.textStyle),
                              ],
                            ),
                            child: CupertinoSwitch(
                              value: false,
                              onChanged: (value) {},
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: Settings.getBrightness,
                            builder: (_, state, __) {
                              return CupertinoFormRow(
                                prefix: const Text('Tema'),
                                child: CupertinoSegmentedControl<Brightness>(
                                  children: const {
                                    Brightness.light: Text('Claro'),
                                    Brightness.dark: Text('Escuro'),
                                  },
                                  onValueChanged: Settings.setBrightness,
                                  groupValue: Settings.getBrightness.value,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      CupertinoFormSection(
                        header: const Text('Cuenta'),
                        children: [
                          CupertinoFormRow(
                            prefix: const Text('Cerrar sesión'),
                            child: CupertinoButton(
                              child: const Text('Cerrar sesión'),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
