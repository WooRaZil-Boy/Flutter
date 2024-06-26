import 'package:fast_app_base/common/common.dart';
import 'package:flutter/material.dart';

// 해당 위젯에 Rounded를 설정해 주는 공통 widget
class RoundedContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final double radius;
  final Color? backgroundColor;

  const RoundedContainer(
      {required this.child,
      super.key,
      this.radius = 20,
      this.backgroundColor,
      this.margin,
      this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 15)});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          color: backgroundColor ?? context.appColors.roundedLayoutBackground,
          borderRadius: BorderRadius.circular(radius)),
      child: child,
    );
  }
}
