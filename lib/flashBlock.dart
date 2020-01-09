import 'dart:async';

import 'package:flutter/material.dart';

enum FlashState { Flash_On,Flash_OFF , Flash_Auto }

class IconBlock {
  FlashState currentFlashState = FlashState.Flash_OFF;
  Icon _icon = Icon(Icons.flash_off);

  final _iconstreamcontroller = StreamController<Icon>();
  final _iconchangestreamcontroller = StreamController<Icon>();

  Stream<Icon> get iconStream => _iconstreamcontroller.stream;
  StreamSink<Icon> get iconsink => _iconchangestreamcontroller.sink;
  StreamSink<Icon> get iconchange => _iconstreamcontroller.sink;

  IconBlock() {
    _iconstreamcontroller.add(_icon);
    _iconchangestreamcontroller.stream.listen(_change);
  }
  _change(Icon icon) {
    currentFlashState = currentFlashState.index < FlashState.values.length - 1
        ? FlashState.values[currentFlashState.index + 1]
        : FlashState.values[0];
    if (currentFlashState == FlashState.Flash_On) {
      _icon = Icon(Icons.flash_off);
      iconchange.add(_icon);
      print("Hello");
      //Lamp.turnOn(); Turning on the flash through lamp package flutter but the flash not opening
    } else if (currentFlashState == FlashState.Flash_Auto) {
      _icon = Icon(Icons.flash_on);
      iconchange.add(_icon);
      print("Hello");
    } else {
      _icon = Icon(Icons.flash_auto);
      iconchange.add(_icon);
      print("Hello");
      //Lamp.turnOff();
    }
  }

  void dispose() {
    _iconstreamcontroller.close();
    _iconchangestreamcontroller.close();
  }
}
