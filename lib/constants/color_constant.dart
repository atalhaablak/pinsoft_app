import 'package:flutter/material.dart';

// Genel Temamızın renk kodunu sürekli kullanmamak için yapı oluşturuldu.

class ColorConstant {
  static ColorConstant instance = ColorConstant._init();
  ColorConstant._init();

  final shadowColor = Color(0xffAA9D8E);
  final backgroundColor = Color(0xff161410);
}
