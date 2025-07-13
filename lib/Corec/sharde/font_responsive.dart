import 'package:flutter/material.dart';

double getFontSize(context, double baseSize) {
  double screenWidth = MediaQuery.of(context).size.width;
  return screenWidth < 600 ? baseSize : baseSize * 1.5;
}

int getCrossAxisCount(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;

  if (screenWidth < 600) {
    return 2;
  } else if (screenWidth < 900) {
    return 3;
  } else {
    return 4;
  }
}

double getChildAspectRatio(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  bool isLandscape =
      MediaQuery.of(context).orientation == Orientation.landscape;

  if (isLandscape) {
    return screenWidth / (screenHeight / 1.5);
  } else {
    if (screenWidth < 600) {
      return screenWidth / (screenHeight / 2.0);
    } else if (screenWidth < 900) {
      return screenWidth / (screenHeight / 1.8);
    } else {
      return screenWidth / (screenHeight / 1.6);
    }
  }
}
