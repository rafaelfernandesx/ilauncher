import 'package:rlauncher/src/core/services/persist_service.dart';

class Settings {
  static const String _defaultWallPaper = "assets/images/bg/bg3.jpeg";
  static String? _wallpaperPath;

  static Future<bool> setWallpaperPath(String path) async {
    final result = await Persist.setString('_wallpaperPath', path);
    if (result) {
      _wallpaperPath = path;
      return true;
    }
    return false;
  }

  static String get getWallpaperPath {
    return _wallpaperPath ?? _defaultWallPaper;
  }
}
