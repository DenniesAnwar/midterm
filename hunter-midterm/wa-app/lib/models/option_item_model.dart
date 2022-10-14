import 'package:flutter/material.dart';

class Options {
  late String iconPath;
  late String title;
  late int index;
  late Widget loadWidget;
  Options(
      {required this.title,
      required this.index,
      required this.iconPath,
      required this.loadWidget});
}
