import 'dart:async';
import 'dart:developer';

import 'package:flutter/services.dart';

class FullscreenService {
  Timer? timer;
  static FullscreenService? _instance;
  FullscreenService._internal() {
    log('FullscreenService started');
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    });
  }

  factory FullscreenService() => _instance ?? FullscreenService._internal();

  void cancelTimer() {
    log('FullscrenService ended');
    timer!.cancel();
  }
}
