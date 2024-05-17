import 'package:flutter/cupertino.dart';

class BrightnessSM extends ValueNotifier<Brightness> {
  BrightnessSM(super.value);

  void setBrightness(Brightness brightness) {
    value = brightness;
  }
}
