import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/main/tab/benefit/vo_benefit.dart';
import 'package:flutter/material.dart';

class BenefitItem extends StatelessWidget {
  final Benefit benefit;

  const BenefitItem({super.key, required this.benefit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          benefit.imagePath,
          width: 50,
          height: 50,
        ),
        width10,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            benefit.subTitle.text.size(13).make(),
            height5,
            // 단순히 .blue로 해도 되지만, light / dark 모드를 감안해서 만들어 두는 것이 좋다.
            benefit.title.text.color(context.appColors.blueText).size(13).make(),
          ],
        )
      ],
    ).pSymmetric(v: 20);
  }
}
