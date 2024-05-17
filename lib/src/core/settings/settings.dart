import 'package:rlauncher/src/core/services/persist_service.dart';
import 'package:wallpaper_handler/wallpaper_handler.dart';

class Settings {
  static const String _defaultWallPaper = "assets/images/bg/bg2.jpg";
  static String? _wallpaperPath;

  static Future<bool> _setWallpaperPath(String path) async {
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

  static Future<bool> setWallpaper(
      String path, WallpaperLocation wallpaperLocation) async {
    final result = await WallpaperHandler.instance
        .setWallpaperFromAsset(path, wallpaperLocation);
    if (result) {
      return await _setWallpaperPath(path);
    }
    return false;
  }
}
