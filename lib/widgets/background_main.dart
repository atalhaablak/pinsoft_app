import 'package:flutter/material.dart';
import 'package:pinsoft_movie_app/constants/color_constant.dart';
import '../constants/context_extension.dart';
class BackgroundMain extends StatelessWidget {
  final Widget bodyWidget;
  BackgroundMain(this.bodyWidget);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.dynamicMultiWidth(1),
      height: context.dynamicHeight(1),
      decoration: BoxDecoration(
        color: ColorConstant.instance.shadowColor
      ),
      child: bodyWidget,
    );
  }
}
