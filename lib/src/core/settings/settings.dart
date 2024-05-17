import 'package:flutter/cupertino.dart';
import 'package:wallpaper_handler/wallpaper_handler.dart';

import '../services/persist_service.dart';
import 'state_manager/brightness_sm.dart';

class Settings {
  static const String _defaultWallPaper = 'assets/images/bg/bg3.jpeg';
  static String? _wallpaperPath;
  static final BrightnessSM _brightness = BrightnessSM(Brightness.light);

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

  static Future<bool> setWallpaper(String path, WallpaperLocation wallpaperLocation) async {
    final result = await WallpaperHandler.instance.setWallpaperFromAsset(path, wallpaperLocation);
    if (result) {
      return _setWallpaperPath(path);
    }
    return false;
  }

  static BrightnessSM get getBrightness {
    return _brightness;
  }

  static void setBrightness(Brightness brightness) {
    _brightness.value = brightness;
  }
}
