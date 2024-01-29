import 'package:flutter/material.dart';

class Gaps {
  Gaps._();

  static SizedBox horizontalGapOf(double width) {
    return SizedBox(
      width: width,
    );
  }

  static SizedBox verticalGapOf(double height) {
    return SizedBox(
      height: height,
    );
  }

  static SizedBox bothGapOf(double height, double width) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}









