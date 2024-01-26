import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomScrollHelper extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
