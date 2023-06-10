import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static Brightness? brightness;
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;
  static double blockSizeHorizontal = 0.0;
  static double blockSizeVertical = 0.0;

  static double _safeAreaHorizontal = 0.0;
  static double _safeAreaVertical = 0.0;
  static double safeBlockHorizontal = 0.0;
  static double safeBlockVertical = 0.0;
  static double smallestSize = 0.0;
  static double largestSize = 0.0;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    brightness = _mediaQueryData!.platformBrightness;
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    blockSizeHorizontal = (screenWidth / 100);
    blockSizeVertical = (screenHeight / 100);
    smallestSize = blockSizeVertical < blockSizeHorizontal ? blockSizeVertical : blockSizeHorizontal;
    largestSize = blockSizeVertical > blockSizeHorizontal ? blockSizeVertical : blockSizeHorizontal;

    _safeAreaHorizontal = _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
    _safeAreaVertical = _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}
