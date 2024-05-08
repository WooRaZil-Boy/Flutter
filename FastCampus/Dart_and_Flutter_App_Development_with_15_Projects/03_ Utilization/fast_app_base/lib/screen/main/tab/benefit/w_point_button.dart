import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/widget/w_arrow.dart';
import 'package:flutter/material.dart';

// 값이 변화하지만, 외부에서 주입되어 변하는 것이기 때문에 StatelessWidget으로 사용한다.
class PointButton extends StatelessWidget {
  final int point;

  const PointButton({super.key, required this.point});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        "내 포인트".text.color(context.appColors.lessImportant).make(),
        emptyExpanded,
        "$point 원".text.bold.make(),
        width10,
        Arrow(
          color: context.appColors.lessImportant,
        ),
      ],
    );
  }
}
